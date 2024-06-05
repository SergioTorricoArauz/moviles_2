// To parse this JSON data, do
//
//     final pelicula = peliculaFromJson(jsonString);

import 'dart:convert';

Pelicula peliculaFromJson(String str) => Pelicula.fromJson(json.decode(str));

String peliculaToJson(Pelicula data) => json.encode(data.toJson());

class Pelicula {
  int? id;
  String nombre;
  String imagen;

  Pelicula({
    required this.nombre,
    required this.imagen,
  });

  factory Pelicula.fromJson(Map<String, dynamic> json) => Pelicula(
        nombre: json["nombre"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "imagen": imagen,
      };
}
