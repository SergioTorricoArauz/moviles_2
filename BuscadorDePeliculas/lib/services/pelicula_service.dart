import 'dart:convert';
import 'package:buscador_de_peliculas/models/pelicula.dart';
import 'package:http/http.dart' as http;

class PeliculaService {
  Future<Pelicula> obtenerDatosPelicula() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/550?api_key=b284941f0d978f04beae57bd292c484d');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      // Comprueba si jsonResponse es nulo antes de intentar usarlo
      if (jsonResponse == null) {
        throw Exception('No se pudo obtener los datos de la película');
      }

      return Pelicula.fromJson(jsonResponse);
    } else {
      throw Exception('Solicitud fallida con estado: ${response.statusCode}.');
    }
  }

  Future<List<Pelicula>> obtenerListaPeliculas(int pagina) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=b284941f0d978f04beae57bd292c484d&page=$pagina');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      // Comprueba si jsonResponse es nulo antes de intentar usarlo
      if (jsonResponse == null) {
        throw Exception('No se pudo obtener la lista de películas');
      }

      var peliculas = (jsonResponse['results'] as List<dynamic>)
          .map((item) => Pelicula.fromJson(item))
          .toList();
      return peliculas;
    } else {
      throw Exception('Solicitud fallida con estado: ${response.statusCode}.');
    }
  }

  Future<List<Pelicula>> buscarPeliculas(String query) async {
    try {
      var url = Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=b284941f0d978f04beae57bd292c484d&query=$query');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        // Comprueba si jsonResponse es nulo antes de intentar usarlo
        if (jsonResponse == null) {
          throw Exception('No se pudo buscar las películas');
        }

        var peliculas = (jsonResponse['results'] as List<dynamic>)
            .map((item) => Pelicula.fromJson(item))
            .toList();
        return peliculas;
      } else {
        throw Exception(
            'Solicitud fallida con estado: ${response.statusCode}.');
      }
    } catch (e) {
      throw Exception('Ocurrió un error al realizar la solicitud: $e');
    }
  }

  Future<List<Pelicula>> buscarPeliculasPorAno(int year) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=b284941f0d978f04beae57bd292c484d&primary_release_year=$year');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      // Comprueba si jsonResponse es nulo antes de intentar usarlo
      if (jsonResponse == null) {
        throw Exception('No se pudo buscar las películas');
      }

      var peliculas = (jsonResponse['results'] as List<dynamic>)
          .map((item) => Pelicula.fromJson(item))
          .toList();
      return peliculas;
    } else {
      throw Exception('Solicitud fallida con estado: ${response.statusCode}.');
    }
  }

  Future<List<Pelicula>> obtenerPeliculasRecomendadas() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=b284941f0d978f04beae57bd292c484d');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      // Comprueba si jsonResponse es nulo antes de intentar usarlo
      if (jsonResponse == null) {
        throw Exception(
            'No se pudo obtener la lista de películas recomendadas');
      }

      var peliculas = (jsonResponse['results'] as List<dynamic>)
          .map((item) => Pelicula.fromJson(item))
          .toList();
      return peliculas;
    } else {
      throw Exception('Solicitud fallida con estado: ${response.statusCode}.');
    }
  }

  Future<Pelicula> obtenerPeliculasPorId(int id) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=b284941f0d978f04beae57bd292c484d');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      // Comprueba si jsonResponse es nulo antes de intentar usarlo
      if (jsonResponse == null) {
        throw Exception('No se pudo obtener la película con id $id');
      }

      var pelicula = Pelicula.fromJson(jsonResponse);
      return pelicula;
    } else {
      throw Exception('Solicitud fallida con estado: ${response.statusCode}.');
    }
  }
}
