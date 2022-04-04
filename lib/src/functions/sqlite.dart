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
          '''CREATE TABLE tickets(id INTEGER PRIMARY KEY, issuer TEXT,  date TEXT, total INTEGER, photo BLOB, categ TEXT)''');
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

  static Future<List<Ticket>> getAll() async {
    var database = await _openDB();
    var tickets = await database.query('tickets');
    return tickets.isNotEmpty
        ? tickets.map((c) => Ticket.fromMap(c)).toList()
        : [];
  }

  static Future<List<Ticket>> getOne() async {
    var database = await _openDB();
    List<Map<String, dynamic>> tickets = await database.query('tickets');
    return List.generate(
      tickets.length,
      (i) => Ticket(
          issuer: tickets[i]['issuer'],
          date: tickets[i]['date'],
          total: tickets[i]['total'],
          photo: tickets[i]['photo'],
          categ: tickets[i]['categ']),
    );
  }
}
