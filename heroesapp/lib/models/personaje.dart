// To parse this JSON data, do
//
//     final personaje = personajeFromJson(jsonString);

import 'dart:convert';

Personaje personajeFromJson(String str) => Personaje.fromJson(json.decode(str));

String personajeToJson(Personaje data) => json.encode(data.toJson());

class Personaje {
  int? id;
  String nombre;
  String nombreSuperheroe;
  int edad;
  String imagen;
  int peso;
  int altura;
  String planeta;
  String historia;
  int fuerza;
  int inteligencia;
  int agilidad;
  int resistencia;
  int velocidad;
  int idPelicula;
  int idTipo;

  Personaje({
    this.id,
    required this.nombre,
    required this.nombreSuperheroe,
    required this.edad,
    required this.imagen,
    required this.peso,
    required this.altura,
    required this.planeta,
    required this.historia,
    required this.fuerza,
    required this.inteligencia,
    required this.agilidad,
    required this.resistencia,
    required this.velocidad,
    required this.idPelicula,
    required this.idTipo,
  });

  factory Personaje.fromJson(Map<String, dynamic> json) => Personaje(
        id: json["id"],
        nombre: json["nombre"],
        nombreSuperheroe: json["nombreSuperheroe"],
        edad: json["edad"],
        imagen: json["imagen"],
        peso: json["peso"],
        altura: json["altura"],
        planeta: json["planeta"],
        historia: json["historia"],
        fuerza: json["fuerza"],
        inteligencia: json["inteligencia"],
        agilidad: json["agilidad"],
        resistencia: json["resistencia"],
        velocidad: json["velocidad"],
        idPelicula: json["idPelicula"],
        idTipo: json["idTipo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "nombreSuperheroe": nombreSuperheroe,
        "edad": edad,
        "imagen": imagen,
        "peso": peso,
        "altura": altura,
        "planeta": planeta,
        "historia": historia,
        "fuerza": fuerza,
        "inteligencia": inteligencia,
        "agilidad": agilidad,
        "resistencia": resistencia,
        "velocidad": velocidad,
        "idPelicula": idPelicula,
        "idTipo": idTipo,
      };
}
