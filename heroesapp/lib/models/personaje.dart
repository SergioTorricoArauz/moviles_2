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
  int? idTipo;

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
    required this.idTipo,
  });

  factory Personaje.fromJson(Map<String, dynamic> json) => Personaje(
        id: json["id"] ?? 0,
        nombre: json["nombre"] ?? '',
        nombreSuperheroe: json["nombreSuperheroe"] ?? '',
        edad: json["edad"] ?? 0,
        imagen: json["imagen"] ?? '',
        peso: json["peso"] ?? 0,
        altura: json["altura"] ?? 0,
        planeta: json["planeta"] ?? '',
        historia: json["historia"] ?? '',
        fuerza: json["fuerza"] ?? 0,
        inteligencia: json["inteligencia"] ?? 0,
        agilidad: json["agilidad"] ?? 0,
        resistencia: json["resistencia"] ?? 0,
        velocidad: json["velocidad"] ?? 0,
        idTipo: json["idTipo"] ?? 0,
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
        "idTipo": idTipo,
      };
}
