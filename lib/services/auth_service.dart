import 'dart:convert';

import 'package:chat/global/environment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;
  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => _autenticando;

  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  // Getters del token de forma estatica
  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token!;
  }

  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;
    final data = {
      'email': email,
      'password': password,
    };
    final url = Uri.http(Enviroment.apiUrl, '/api/login');
    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      //! Guardar token
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future _guardarToken(String token) async {
    // Write value
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    // Delete value
    await _storage.delete(key: 'token');
  }

  Future register(
      {required String nombre,
      required String email,
      required String password}) async {
    autenticando = true;
    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
    };

    final url = Uri.http(Enviroment.apiUrl, '/api/login/new');
    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      //! Guardar token
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  // Para validar si ya esta logueado o tiene token activo
  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    final url = Uri.http(Enviroment.apiUrl, '/api/login/renew');
    final resp = await http.get(url,
        headers: {'Content-Type': 'application/json', 'x-token': token ?? ''});
    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.usuario;
      //! Guardar token
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }
}
