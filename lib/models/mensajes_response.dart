// To parse this JSON data, do
//
//     final mensajesResponse = mensajesResponseFromJson(jsonString);

import 'dart:convert';

MensajesResponse mensajesResponseFromJson(String str) =>
    MensajesResponse.fromJson(json.decode(str));

String mensajesResponseToJson(MensajesResponse data) =>
    json.encode(data.toJson());

class MensajesResponse {
  final bool ok;
  final List<Mensaje> mensajes;

  MensajesResponse({
    required this.ok,
    required this.mensajes,
  });

  factory MensajesResponse.fromJson(Map<String, dynamic> json) =>
      MensajesResponse(
        ok: json["ok"],
        mensajes: List<Mensaje>.from(
            json["mensajes"].map((x) => Mensaje.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
      };
}

class Mensaje {
  final String de;
  final String para;
  final bool online;
  final String mensaje;
  final String createdAt;
  final String updatedAt;

  Mensaje({
    required this.de,
    required this.para,
    required this.online,
    required this.mensaje,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        de: json["de"],
        para: json["para"],
        online: json["online"],
        mensaje: json["mensaje"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "de": de,
        "para": para,
        "online": online,
        "mensaje": mensaje,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
