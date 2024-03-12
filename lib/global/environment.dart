import 'dart:io';

class Enviroment {
  // Rest
  static String apiUrl =
      Platform.isAndroid ? "10.0.2.2:3000" : "localhost:3000";
  // Socket
  static String socketUrl =
      Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';
}
