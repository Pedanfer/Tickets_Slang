import 'package:exploration_planner/src/ticket.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'tickets.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE tickets (id INTEGER PRIMARY KEY, issuer TEXT,  date INTEGER, total INTEGER, photo BLOB)');
    }, version: 1);
  }

  static Future<int> insert(Ticket ticket) async {
    var database = await _openDB();
    return database.insert('tickets', ticket.toMap());
  }

  static Future<int> delete(Ticket ticket) async {
    var database = await _openDB();
    return database.delete('tickets', where: 'id = ?', whereArgs: [ticket.id]);
  }

  static Future<int> update(Ticket ticket) async {
    var database = await _openDB();
    return database.update('tickets', ticket.toMap(), whereArgs: [ticket.id]);
  }

  static Future<List<Ticket>> getAll() async {
    var database = await _openDB();
    List<Map<String, dynamic>> tickets = await database.query('tickets');
    return List.generate(
        tickets.length,
        (i) => Ticket(
              tickets[i]['id'],
              tickets[i]['issuer'],
              tickets[i]['total'],
              tickets[i]['date'],
              tickets[i]['photo'],
            ));
  }
}
