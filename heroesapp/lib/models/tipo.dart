// To parse this JSON data, do
//
//     final tipo = tipoFromJson(jsonString);

import 'dart:convert';

Tipo tipoFromJson(String str) => Tipo.fromJson(json.decode(str));

String tipoToJson(Tipo data) => json.encode(data.toJson());

class Tipo {
  int? id;
  String nombre;

  Tipo({
    this.id,
    required this.nombre,
  });

  factory Tipo.fromJson(Map<String, dynamic> json) => Tipo(
        id: json["id"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
      };
}
