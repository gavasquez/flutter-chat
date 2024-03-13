import 'package:chat/global/environment.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';

// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

// ignore: constant_identifier_names
enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  final ServerStatus _serverStatus = ServerStatus.Online;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  void connect() async {
    final token =await AuthService.getToken();
    print(token);

    // Dart client
    _socket = IO.io(
        Enviroment.socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .enableForceNew()
            .setExtraHeaders({'x-token': token})
            .build());

  
    //_socket.onConnect((data) {
    //  _serverStatus = ServerStatus.Online;
    //  notifyListeners();
    //});

    //_socket.onDisconnect((_) {
    //  _serverStatus = ServerStatus.Offline;
    //  notifyListeners();
    //});
  }

  void disconnect() {
    _socket.disconnect();
  }
}
