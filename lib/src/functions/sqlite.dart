import 'package:slang_mobile/src/utils/ticket.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  //Singleton pattern
  static Database? _database;
  DB._privateConstructor();
  static final DB instance = DB._privateConstructor();

  Future<Database> get database async => _database ??= await _openDB();

  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'tickets.db'),
        onCreate: (db, version) {
      return db.execute(
          '''CREATE TABLE tickets(id INTEGER PRIMARY KEY, ticketName TEXT, synchronized INTEGER, issuer TEXT,  date TEXT, hour TEXT, total REAL, photo BLOB, categ1 TEXT, categ2 TEXT)''');
    }, version: 1);
  }

  static Future<int> insert(Ticket ticket) async {
    var database = await instance.database;
    return database.insert('tickets', ticket.toMap());
  }

  static Future<int> delete(int id) async {
    var database = await _openDB();
    return database.delete('tickets', where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteList(List<Ticket> tickets) async {
    var ticketsId =
        List<String>.generate(tickets.length, (i) => tickets[i].id.toString())
            .reduce((value, element) => value + ',' + element);
    var database = await _openDB();
    return database
        .rawUpdate('DELETE FROM tickets WHERE id IN(' + ticketsId + ');');
  }

  static Future<int> updateSynchronized(List<Ticket> tickets) async {
    var ticketsId =
        List<String>.generate(tickets.length, (i) => tickets[i].id.toString())
            .reduce((value, element) => value + ',' + element);
    var database = await _openDB();
    return database.rawUpdate(
        'UPDATE tickets SET synchronized = 1 WHERE id IN(' + ticketsId + ');');
  }

  static Future<int> updateTicket(List<String> fields, int id) async {
    var database = await _openDB();
    return database.rawUpdate(
      'UPDATE tickets SET ticketName = ?, categ1 = ?, categ2 = ? WHERE id = ?',
      fields..add(id.toString()),
    );
  }

  static Future<List<Ticket>> filter(String dateStart, String dateEnd,
      String categ1, String categ2, List<bool> synchronizor) async {
    var database = await _openDB();
    List<dynamic>? tickets;
    var categ1None = categ1.isEmpty;
    var categ2None = RegExp(categ2).hasMatch('Todas');
    var synchronized = synchronizor[0] ? '1' : '0';
    var optionSync = ')';
    if (synchronizor[0] && synchronizor[1]) {
      optionSync = ' OR synchronized = 0)';
    } else if (!synchronizor[0] && !synchronizor[1]) {
      optionSync = ' OR synchronized = 1)';
    }
    if (dateStart != 'Inicio') {
      if (!categ1None) {
        if (categ2None) {
          tickets = await database.query('tickets',
              where:
                  'date BETWEEN ? AND ? AND categ1 = ? AND (synchronized = ?' +
                      optionSync,
              whereArgs: [dateStart, dateEnd, categ1, synchronized]);
        } else {
          tickets = await database.query('tickets',
              where:
                  'date BETWEEN ? AND ? AND categ1 = ? AND categ2 = ? AND (synchronized = ?' +
                      optionSync,
              whereArgs: [dateStart, dateEnd, categ1, categ2, synchronized]);
        }
      } else if (categ2None) {
        tickets = await database.query('tickets',
            where: 'date BETWEEN ? AND ? AND (synchronized = ?' + optionSync,
            whereArgs: [dateStart, dateEnd, synchronized]);
      }
    } else {
      if (!categ1None) {
        if (categ2None) {
          tickets = await database.query('tickets',
              where: 'categ1 = ? AND (synchronized = ?' + optionSync,
              whereArgs: [categ1, synchronized]);
        } else {
          tickets = await database.query('tickets',
              where: 'categ1 = ? AND categ2 = ? AND (synchronized = ?' +
                  optionSync,
              whereArgs: [categ1, categ2, synchronized]);
        }
      } else if (categ2None) {
        tickets = await database.query('tickets',
            where: '(synchronized = ?' + optionSync, whereArgs: [synchronized]);
      }
    }
    return tickets!.isNotEmpty
        ? tickets.map((c) => Ticket.fromMap(c)).toList()
        : [];
  }
}
