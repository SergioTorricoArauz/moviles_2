import 'package:buscador_de_peliculas/dal/pelicula_dal.dart';
import 'package:buscador_de_peliculas/dal/peliculas_personajes_dal.dart';
import 'package:buscador_de_peliculas/models/pelicula.dart';
import 'package:buscador_de_peliculas/models/peliculas_personaje.dart';

class PeliculasPersonajesBLL {
  static Future<List<PeliculasPersonajes>> selectAll() async {
    var res = await PeliculasPersonajesDAL.selectAll();
    List<PeliculasPersonajes> list =
        res.isNotEmpty ? res.map((c) => c).toList() : [];
    return list;
  }

  static Future<PeliculasPersonajes?> selectById(int id) async {
    var peliculasPersonajesEncontrado =
        await PeliculasPersonajesDAL.selectById(id);
    if (peliculasPersonajesEncontrado != null) {
      return peliculasPersonajesEncontrado;
    } else {
      throw Exception('PeliculasPersonajes no encontrado');
    }
  }

  static Future<int> insert(PeliculasPersonajes peliculasPersonajes) async {
    return await PeliculasPersonajesDAL.insert(peliculasPersonajes);
  }

  static Future<int> update(PeliculasPersonajes peliculasPersonajes) async {
    return await PeliculasPersonajesDAL.update(peliculasPersonajes);
  }

  static Future<int> delete(int id) async {
    return await PeliculasPersonajesDAL.delete(id);
  }

  static Future<List<int>> selectIds() async {
    var res = await PeliculasPersonajesDAL.selectIds();
    return res;
  }

  static Future<List<int>> getTipos() async {
    var res = await PeliculasPersonajesDAL.selectIds();
    return res;
  }

  static Future<List<Pelicula>> getPeliculasPorPersonajeId(
      int idPersonaje) async {
    List<int> peliculaIds =
        await PeliculasPersonajesDAL.selectPeliculaIdsByPersonajeId(
            idPersonaje);
    List<Pelicula> peliculas = [];
    for (int id in peliculaIds) {
      Pelicula? pelicula = await PeliculaDAL.selectById(id);
      peliculas.add(pelicula!);
    }
    return peliculas;
  }
}
