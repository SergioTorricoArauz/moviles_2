import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

final _logger = Logger('Pelicula');

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
    var releaseDate = json['release_date'];
    DateTime? parsedDate;
    if (releaseDate is String && releaseDate.isNotEmpty) {
      try {
        parsedDate = DateFormat('yyyy-MM-dd').parseStrict(releaseDate);
      } catch (e) {
        _logger.severe('Error parsing date: $e');
        parsedDate = null;
      }
    }

    var pelicula = Pelicula(
      id: json['id'],
      title: json['title'],
      releaseDate: parsedDate,
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
