import 'package:exploration_planner/src/utils/ticket.dart';
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
          '''CREATE TABLE tickets(id INTEGER PRIMARY KEY, issuer TEXT,  date TEXT, hour TEXT, total INTEGER, photo BLOB, categ1 TEXT, categ2 TEXT)''');
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

  static Future<int> update(Ticket ticket) async {
    var database = await _openDB();
    return database.update('tickets', ticket.toMap(), whereArgs: [ticket.id]);
  }

  static Future<List<Ticket>> filter(
      String dateStart, String dateEnd, String categ1, String categ2) async {
    var database = await _openDB();
    List<dynamic>? tickets;
    var categ1None = RegExp(categ1).hasMatch('|Todas');
    var categ2None = RegExp(categ2).hasMatch('|Todas');
    if (dateStart != 'Fecha inicio') {
      if (!categ1None) {
        if (categ2None) {
          tickets = await database.query('tickets',
              where: 'date BETWEEN ? AND ? AND categ1 = ?',
              whereArgs: [dateStart, dateEnd, categ1]);
        } else {
          tickets = await database.query('tickets',
              where: 'date BETWEEN ? AND ? AND categ1 = ? AND categ2 = ?',
              whereArgs: [dateStart, dateEnd, categ1, categ2]);
        }
      } else if (!categ2None) {
        tickets = await database.query('tickets',
            where: 'date BETWEEN ? AND ? AND categ2 = ?',
            whereArgs: [dateStart, dateEnd, categ2]);
      } else {
        tickets = await database.query('tickets',
            where: 'date BETWEEN ? AND ?', whereArgs: [dateStart, dateEnd]);
      }
    } else {
      if (!categ1None) {
        if (categ2None) {
          tickets = await database
              .query('tickets', where: 'categ1 = ?', whereArgs: [categ1]);
        } else {
          tickets = await database.query('tickets',
              where: 'categ1 = ? AND categ2 = ?', whereArgs: [categ1, categ2]);
        }
      } else if (!categ2None) {
        tickets = await database
            .query('tickets', where: 'categ2 = ?', whereArgs: [categ2]);
      } else {
        tickets = await database.query('tickets');
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
