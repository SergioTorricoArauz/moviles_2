import 'package:buscador_de_peliculas/dal/pelicula_dal.dart';
import 'package:buscador_de_peliculas/models/pelicula.dart';

class PeliculaBLL {
  static Future<List<Pelicula>> selectAll() async {
    var res = await PeliculaDAL.selectAll();
    List<Pelicula> list = res.isNotEmpty ? res.map((c) => c).toList() : [];
    return list;
  }

  static Future<Pelicula?> selectById(int id) async {
    var peliculaEncontrada = await PeliculaDAL.selectById(id);
    if (peliculaEncontrada != null) {
      return peliculaEncontrada;
    } else {
      throw Exception('Pelicula no encontrada');
    }
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
