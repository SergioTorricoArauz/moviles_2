import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static Database? _database;
  static final DatabaseProvider db = DatabaseProvider._();

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  static initDB() async {
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, "dbheroes.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE personaje ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "nombre TEXT,"
          "nombreSuperheroe TEXT,"
          "edad INTEGER,"
          "imagen TEXT,"
          "peso INTEGER,"
          "altura INTEGER,"
          "planeta TEXT,"
          "historia TEXT,"
          "fuerza INTEGER,"
          "inteligencia INTEGER,"
          "agilidad INTEGER,"
          "resistencia INTEGER,"
          "velocidad INTEGER,"
          "idPelicula INTEGER,"
          "idTipo INTEGER,"
          "FOREIGN KEY (idTipo) REFERENCES tipos(id),"
          "FOREIGN KEY (idPelicula) REFERENCES peliculas(id)"
          ")");
      await db.execute("CREATE TABLE peliculas ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "nombre TEXT,"
          "imagen TEXT"
          ")");
      await db.execute("CREATE TABLE tipos ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "nombre TEXT"
          ")");
    });
  }
}
