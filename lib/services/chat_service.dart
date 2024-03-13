import 'package:chat/global/environment.dart';
import 'package:chat/models/mensajes_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    // Obtener token
    final token = await AuthService.getToken();
    // Uri para la peticion
    final url = Uri.http(Enviroment.apiUrl, '/api/mensajes/$usuarioID');
    final resp = await http.get(url,
        headers: {'Content-Type': 'application/json', 'x-token': token});

    final mensajeResp = mensajesResponseFromJson(resp.body);
    // Regresamos los mensajes
    return mensajeResp.mensajes;
  }
}
