import 'package:heroes_app/dal/pelicula_dal.dart';
import 'package:heroes_app/models/pelicula.dart';

class PeliculaBLL {
  static Future<List<Pelicula>> selectAll() async {
    var res = await PeliculaDAL.selectAll();
    List<Pelicula> list = res.isNotEmpty ? res.map((c) => c).toList() : [];
    return list;
  }

  static Future<Pelicula?> selectById(int id) async {
    return await PeliculaDAL.selectById(id);
  }

  static Future<int> insert(Pelicula pelicula) async {
    return await PeliculaDAL.insert(pelicula);
  }

  static Future<int> update(Pelicula pelicula) async {
    return await PeliculaDAL.update(pelicula);
  }

  static Future<int> delete(int id) async {
    return await PeliculaDAL.delete(id);
  }
}
