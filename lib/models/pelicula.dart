import 'package:intl/intl.dart';

class Pelicula {
  final int? id;
  String? title;
  String? name;
  DateTime? releaseDate;
  int? runtime;
  List<String>? genres;
  String? overview;
  String? imageUrl;
  String? backdropPath;
  double? popularity;
  double? voteAverage;

  Pelicula({
    this.id,
    this.title,
    this.name,
    this.releaseDate,
    this.runtime,
    this.genres,
    this.overview,
    this.imageUrl,
    this.backdropPath,
    this.popularity,
    this.voteAverage,
  });

  factory Pelicula.fromJson(Map<String, dynamic> json) {
    var pelicula = Pelicula(
      id: json['id'],
      title: json['title'],
      releaseDate: json['release_date'] != null
          ? DateFormat('yyyy-MM-dd').parse(json['release_date'])
          : null,
      runtime: json['runtime'],
      genres: json['genres'] != null
          ? List<String>.from(json['genres'].map((x) => x['name'].toString()))
          : [],
      name: json['name'],
      overview: json['overview'],
      imageUrl: json['poster_path'],
      backdropPath: json['backdrop_path'],
      popularity: json['popularity'],
      voteAverage: json['vote_average'],
    );
    return pelicula;
  }
}

class Director {
  bool adult;
  List<String> alsoKnownAs;
  String biography;
  DateTime birthday;
  dynamic deathday;
  int gender;
  String homepage;
  int id;
  String imdbId;
  String knownForDepartment;
  String name;
  String placeOfBirth;
  double popularity;
  String profilePath;

  Director({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    required this.birthday,
    required this.deathday,
    required this.gender,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
  });
}
