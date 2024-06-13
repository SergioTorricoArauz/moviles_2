// To parse this JSON data, do
//
//     final peliculasPersonajes = peliculasPersonajesFromJson(jsonString);

import 'dart:convert';

PeliculasPersonajes peliculasPersonajesFromJson(String str) =>
    PeliculasPersonajes.fromJson(json.decode(str));

String peliculasPersonajesToJson(PeliculasPersonajes data) =>
    json.encode(data.toJson());

class PeliculasPersonajes {
  int? id;
  int idPelicula;
  int idPersonaje;

  PeliculasPersonajes({
    this.id,
    required this.idPelicula,
    required this.idPersonaje,
  });

  factory PeliculasPersonajes.fromJson(Map<String, dynamic> json) =>
      PeliculasPersonajes(
        id: json["id"],
        idPelicula: json["idPelicula"],
        idPersonaje: json["idPersonaje"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idPelicula": idPelicula,
        "idPersonaje": idPersonaje,
      };
}
