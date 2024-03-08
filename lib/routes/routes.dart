import 'package:chat/pages/pages.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (context) => UsuariosPage(),
  'register': (context) => RegisterPage(),
  'chat': (context) => ChatPage(),
  'login': (context) => LoginPage(),
  'loading': (context) => LoadingPage(),
};
