import 'package:buscador_de_peliculas/dal/tipo_dal.dart';
import 'package:buscador_de_peliculas/models/tipo.dart';

class TipoBLL {
  static Future<List<Tipo>> selectAll() async {
    var res = await TipoDAL.selectAll();
    List<Tipo> list = res.isNotEmpty ? res.map((c) => c).toList() : [];
    return list;
  }

  static Future<Tipo> selectById(int id) async {
    var tipoEncontrado = await TipoDAL.selectById(id);
    if (tipoEncontrado != null) {
      return tipoEncontrado;
    } else {
      throw Exception('Tipo no encontrado');
    }
  }

  static Future<int> insert(Tipo tipo) async {
    return await TipoDAL.insert(tipo);
  }

  static Future<int> update(Tipo tipo) async {
    return await TipoDAL.update(tipo);
  }

  static Future<int> delete(int id) async {
    return await TipoDAL.delete(id);
  }

  static Future<List<int>> getTipos() async {
    var res = await TipoDAL.selectIds();
    return res;
  }

  static getNombrePorId(int id) {
    return selectById(id).then((tipo) => tipo.nombre);
  }
}
