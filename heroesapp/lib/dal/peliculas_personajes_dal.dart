import 'package:buscador_de_peliculas/models/peliculas_personaje.dart';
import 'package:buscador_de_peliculas/providers/database_provider.dart';

class PeliculasPersonajesDAL {
  static Future<int> insert(PeliculasPersonajes peliculasPersonajes) async {
    final db = await DatabaseProvider.database;
    var res =
        await db.insert("peliculas_personaje", peliculasPersonajes.toJson());
    return res;
  }

  static Future<List<PeliculasPersonajes>> selectAll() async {
    final db = await DatabaseProvider.database;
    var res = await db.query("peliculas_personaje");
    List<PeliculasPersonajes> list = res.isNotEmpty
        ? res.map((c) => PeliculasPersonajes.fromJson(c)).toList()
        : [];
    return list;
  }

  static Future<PeliculasPersonajes?> selectById(int id) async {
    final db = await DatabaseProvider.database;
    var res =
        await db.query("peliculas_personaje", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? PeliculasPersonajes.fromJson(res.first) : null;
  }

  static Future<int> update(PeliculasPersonajes peliculasPersonajes) async {
    final db = await DatabaseProvider.database;
    var res = await db.update(
        "peliculas_personaje", peliculasPersonajes.toJson(),
        where: "id = ?", whereArgs: [peliculasPersonajes.id]);
    return res;
  }

  static Future<int> delete(int id) async {
    final db = await DatabaseProvider.database;
    var res = await db
        .delete("peliculas_personaje", where: "id = ?", whereArgs: [id]);
    return res;
  }

  static Future<List<int>> selectIds() async {
    final db = await DatabaseProvider.database;
    var res = await db.query("peliculas_personaje", columns: ["id"]);
    List<int> list =
        res.isNotEmpty ? res.map((c) => c["id"] as int).toList() : [];
    return list;
  }

  static Future<List<int>> selectPeliculaIdsByPersonajeId(
      int idPersonaje) async {
    final db = await DatabaseProvider.database;
    var res = await db.query("peliculas_personaje",
        columns: ["idPelicula"],
        where: "idPersonaje = ?",
        whereArgs: [idPersonaje]);
    List<int> list =
        res.isNotEmpty ? res.map((c) => c["idPelicula"] as int).toList() : [];
    return list;
  }
}
