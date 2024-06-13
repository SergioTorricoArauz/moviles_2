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
    return await openDatabase(path,
        version: 3, onOpen: (db) {}, onUpgrade: _onUpgrade);
  }

  static _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS peliculas");
    await db.execute("DROP TABLE IF EXISTS tipos");
    await db.execute("DROP TABLE IF EXISTS personaje");
    await db.execute("DROP TABLE IF EXISTS peliculas_personaje");
    // Luego, vuelves a crear las tablas.
    await db.execute("CREATE TABLE peliculas ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "nombre TEXT,"
        "imagen TEXT"
        ")");
    await db.execute("CREATE TABLE tipos ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "nombre TEXT"
        ")");
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
        "idTipo INTEGER,"
        "FOREIGN KEY (idTipo) REFERENCES tipos(id)"
        ")");
    await db.execute("CREATE TABLE peliculas_personaje ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "idPelicula INTEGER,"
        "idPersonaje INTEGER,"
        "FOREIGN KEY (idPelicula) REFERENCES peliculas(id),"
        "FOREIGN KEY (idPersonaje) REFERENCES personaje(id)"
        ")");
  }
}
