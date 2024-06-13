import 'package:buscador_de_peliculas/dal/personaje_dal.dart';
import 'package:buscador_de_peliculas/models/personaje.dart';
import 'package:buscador_de_peliculas/providers/database_provider.dart';

class PersonajeBLL {
  static Future<List<Personaje>> selectAll() async {
    var res = await PersonajeDAL.selectAll();
    List<Personaje> list = res.isNotEmpty ? res.map((c) => c).toList() : [];
    return list;
  }

  static Future<Personaje> selectById(int id) async {
    var personajeEncontrado = await PersonajeDAL.selectById(id);
    if (personajeEncontrado != null) {
      return personajeEncontrado;
    } else {
      throw Exception('Personaje no encontrado');
    }
  }

  static Future<int> insert(Personaje personaje) async {
    return await PersonajeDAL.insert(personaje);
  }

  static Future<int> update(Personaje personaje) async {
    return await PersonajeDAL.update(personaje);
  }

  static Future<int> delete(int id) async {
    return await PersonajeDAL.delete(id);
  }

  static Future<List<int>> selectAllIds() async {
    var res = await PersonajeDAL.selectIds();
    return res;
  }

  static Future<List<Personaje>> selectByType(String tipo) async {
    var res = await PersonajeDAL.selectByType(tipo);
    List<Personaje> list = res.isNotEmpty ? res.map((c) => c).toList() : [];
    return list;
  }

  static Future<List<String>> selectUniqueTypes() async {
    final db = await DatabaseProvider.database;
    var res = await db.rawQuery("SELECT DISTINCT tipo FROM personaje");
    List<String> list =
        res.isNotEmpty ? res.map((c) => c['tipo'] as String).toList() : [];
    return list;
  }
}
