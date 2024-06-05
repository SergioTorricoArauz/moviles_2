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
    this.id,
    required this.nombre,
    required this.imagen,
  });

  factory Pelicula.fromJson(Map<String, dynamic> json) => Pelicula(
        id: json["id"],
        nombre: json["nombre"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "imagen": imagen,
      };
}
