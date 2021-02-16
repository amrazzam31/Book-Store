import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model/book.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();

  factory DbHelper() => _instance;

  DbHelper.internal();

  static Database _db;

  Future<Database> createDatabase() async {
    if (_db != null) {
      return _db;
    }
    String path = join(await getDatabasesPath(), 'bookStore.db');
    _db = await openDatabase(path, version: 1, onCreate: (Database db, int v) {
      db.execute(
          "create table books(id integer primary key autoincrement, name varchar(50), description varchar(255), quantity integer, image varchar(255))");
    });
    return _db;
  }

  Future<int> createBook(Book book) async {
    Database db = await createDatabase();
    return db.insert('books', book.toMap());
  }

  Future<List> allBooks() async {
    Database db = await createDatabase();
    return db.query('books');
  }
  Future getBook(int id) async {
    Database db = await createDatabase();
    List<Map> maps =await db.query('books', where: 'id = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }
  Future<int> deleteBook(int id) async {
    Database db = await createDatabase();
    return db.delete('books', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateBook(int id,Book book) async {
    Database db = await createDatabase();
    return db.update('books',book.toMap() ,where: 'id = ?', whereArgs: [id]);
  }
}
