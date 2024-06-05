import 'package:buscador_de_peliculas/models/tipo.dart';
import 'package:buscador_de_peliculas/providers/database_provider.dart';

class TipoDAL {
  static Future<int> insert(Tipo tipo) async {
    final db = await DatabaseProvider.database;
    var res = await db.insert("tipos", tipo.toJson());
    return res;
  }

  static Future<List<Tipo>> selectAll() async {
    final db = await DatabaseProvider.database;
    var res = await db.query("tipos");
    List<Tipo> list =
        res.isNotEmpty ? res.map((c) => Tipo.fromJson(c)).toList() : [];
    return list;
  }

  static Future<Tipo?> selectById(int id) async {
    final db = await DatabaseProvider.database;
    var res = await db.query("tipos", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Tipo.fromJson(res.first) : null;
  }

  static Future<int> update(Tipo tipo) async {
    final db = await DatabaseProvider.database;
    var res = await db
        .update("tipos", tipo.toJson(), where: "id = ?", whereArgs: [tipo.id]);
    return res;
  }

  static Future<int> delete(int id) async {
    final db = await DatabaseProvider.database;
    var res = await db.delete("tipos", where: "id = ?", whereArgs: [id]);
    return res;
  }
}
