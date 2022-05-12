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
    return database.delete('tickets',
        where: 'id = ? AND synchronized = ?', whereArgs: [id]);
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

  static Future<List<Ticket>> filter(String dateStart, String dateEnd,
      String categ1, String categ2, bool synchronizor) async {
    var database = await _openDB();
    List<dynamic>? tickets;
    var categ1None = categ1.isEmpty;
    var categ2None = RegExp(categ2).hasMatch('Todas');
    var synchronized = synchronizor ? '1' : '0';
    if (dateStart != 'Inicio') {
      if (!categ1None) {
        if (categ2None) {
          tickets = await database.query('tickets',
              where: 'date BETWEEN ? AND ? AND categ1 = ? AND synchronized = ?',
              whereArgs: [dateStart, dateEnd, categ1, synchronized]);
        } else {
          tickets = await database.query('tickets',
              where:
                  'date BETWEEN ? AND ? AND categ1 = ? AND categ2 = ? AND synchronized = ?',
              whereArgs: [dateStart, dateEnd, categ1, categ2, synchronized]);
        }
      } else if (!categ2None) {
        tickets = await database.query('tickets',
            where: 'date BETWEEN ? AND ? AND categ2 = ? AND synchronized = ?',
            whereArgs: [dateStart, dateEnd, categ2, synchronized]);
      } else {
        tickets = await database.query('tickets',
            where: 'date BETWEEN ? AND ? AND synchronized = ?',
            whereArgs: [dateStart, dateEnd, synchronized]);
      }
    } else {
      if (!categ1None) {
        if (categ2None) {
          tickets = await database.query('tickets',
              where: 'categ1 = ? AND synchronized = ?',
              whereArgs: [categ1, synchronized]);
        } else {
          tickets = await database.query('tickets',
              where: 'categ1 = ? AND categ2 = ? AND synchronized = ?',
              whereArgs: [categ1, categ2, synchronized]);
        }
      } else if (!categ2None) {
        tickets = await database.query('tickets',
            where: 'categ2 = ? AND synchronized = ?',
            whereArgs: [categ2, synchronized]);
      } else {
        tickets = await database.query('tickets',
            where: 'synchronized = ?', whereArgs: [synchronized]);
      }
    }
    return tickets.isNotEmpty
        ? tickets.map((c) => Ticket.fromMap(c)).toList()
        : [];
  }

  static Future<List<Ticket>> selectByDateRange(
      String dateStart, String dateEnd) async {
    var database = await _openDB();
    var tickets = await database.query('tickets',
        where: 'date BETWEEN ? AND ?', whereArgs: [dateStart, dateEnd]);
    return tickets.isNotEmpty
        ? tickets.map((c) => Ticket.fromMap(c)).toList()
        : [];
  }
}
