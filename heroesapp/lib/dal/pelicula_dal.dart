import 'package:buscador_de_peliculas/models/pelicula.dart';
import 'package:buscador_de_peliculas/providers/database_provider.dart';

class PeliculaDAL {
  static Future<int> insert(Pelicula pelicula) async {
    final db = await DatabaseProvider.database;
    var res = await db.insert("peliculas", pelicula.toJson());
    return res;
  }

  static Future<List<Pelicula>> selectAll() async {
    final db = await DatabaseProvider.database;
    var res = await db.query("peliculas");
    List<Pelicula> list =
        res.isNotEmpty ? res.map((c) => Pelicula.fromJson(c)).toList() : [];
    return list;
  }

  static Future<Pelicula?> selectById(int id) async {
    final db = await DatabaseProvider.database;
    var res = await db.query("peliculas", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Pelicula.fromJson(res.first) : null;
  }

  static Future<int> update(Pelicula pelicula) async {
    final db = await DatabaseProvider.database;
    var res = await db.update("peliculas", pelicula.toJson(),
        where: "id = ?", whereArgs: [pelicula.id]);
    return res;
  }

  static Future<int> delete(int id) async {
    final db = await DatabaseProvider.database;
    var res = await db.delete("peliculas", where: "id = ?", whereArgs: [id]);
    return res;
  }
}
