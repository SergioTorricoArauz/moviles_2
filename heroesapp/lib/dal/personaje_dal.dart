import 'package:buscador_de_peliculas/models/personaje.dart';
import 'package:buscador_de_peliculas/providers/database_provider.dart';

class PersonajeDAL {
  static Future<int> insert(Personaje personaje) async {
    final db = await DatabaseProvider.database;
    var res = await db.insert("personaje", personaje.toJson());
    return res;
  }

  static Future<List<Personaje>> selectAll() async {
    final db = await DatabaseProvider.database;
    var res = await db.query("personaje");
    List<Personaje> list =
        res.isNotEmpty ? res.map((c) => Personaje.fromJson(c)).toList() : [];
    return list;
  }

  static Future<Personaje?> selectById(int id) async {
    final db = await DatabaseProvider.database;
    var res = await db.query("personaje", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Personaje.fromJson(res.first) : null;
  }

  static Future<int> update(Personaje personaje) async {
    final db = await DatabaseProvider.database;
    var res = await db.update("personaje", personaje.toJson(),
        where: "id = ?", whereArgs: [personaje.id]);
    return res;
  }

  static Future<int> delete(int id) async {
    final db = await DatabaseProvider.database;
    var res = await db.delete("personaje", where: "id = ?", whereArgs: [id]);
    return res;
  }

  static Future<List<int>> selectIds() async {
    final db = await DatabaseProvider.database;
    var res = await db.query("personaje", columns: ["idPelicula"]);
    List<int> list =
        res.isNotEmpty ? res.map((c) => c["idPelicula"] as int).toList() : [];
    return list;
  }
}
