import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:buscador_de_peliculas/models/pelicula.dart';

class PeliculaService {
  final client = http.Client();

  Future<Pelicula> obtenerDatosPelicula() async {
    var url =
        'https://api.themoviedb.org/3/movie/550?api_key=b284941f0d978f04beae57bd292c484d';
    var response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('No se pudo obtener los datos de la película');
    }

    var jsonResponse = jsonDecode(response.body);
    return Pelicula.fromJson(jsonResponse);
  }

  Future<List<Pelicula>> obtenerListaPeliculas(int pagina) async {
    var url =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=b284941f0d978f04beae57bd292c484d&page=$pagina';
    var response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('No se pudo obtener la lista de películas');
    }

    var jsonResponse = jsonDecode(response.body);
    var peliculas = (jsonResponse['results'] as List<dynamic>)
        .map((item) => Pelicula.fromJson(item))
        .toList();
    return peliculas;
  }

  Future<List<Pelicula>> buscarPeliculas(String query) async {
    var url =
        'https://api.themoviedb.org/3/search/movie?api_key=b284941f0d978f04beae57bd292c484d&query=$query';
    var response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('No se pudo buscar las películas');
    }

    var jsonResponse = jsonDecode(response.body);
    var peliculas = (jsonResponse['results'] as List<dynamic>)
        .map((item) => Pelicula.fromJson(item))
        .toList();
    return peliculas;
  }

  Future<List<Pelicula>> buscarPeliculasPorAno(int year) async {
    var url =
        'https://api.themoviedb.org/3/discover/movie?api_key=b284941f0d978f04beae57bd292c484d&primary_release_year=$year';
    var response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('No se pudo buscar las películas');
    }

    var jsonResponse = jsonDecode(response.body);
    var peliculas = (jsonResponse['results'] as List<dynamic>)
        .map((item) => Pelicula.fromJson(item))
        .toList();
    return peliculas;
  }

  Future<List<Pelicula>> obtenerPeliculasRecomendadas() async {
    var url =
        'https://api.themoviedb.org/3/movie/popular?api_key=b284941f0d978f04beae57bd292c484d';
    var response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('No se pudo obtener la lista de películas recomendadas');
    }

    var jsonResponse = jsonDecode(response.body);
    var peliculas = (jsonResponse['results'] as List<dynamic>)
        .map((item) => Pelicula.fromJson(item))
        .toList();
    return peliculas;
  }

  Future<Pelicula> obtenerPeliculasPorId(int id) async {
    var url =
        'https://api.themoviedb.org/3/movie/$id?api_key=b284941f0d978f04beae57bd292c484d';
    var response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('No se pudo obtener la película con id $id');
    }

    var jsonResponse = jsonDecode(response.body);
    var pelicula = Pelicula.fromJson(jsonResponse);
    return pelicula;
  }
}
