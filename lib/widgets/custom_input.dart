import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  //* Recibir el valor del texto actual
  final TextEditingController textController;
  //* Tipo de entrada del teclado, email, password
  final TextInputType keyboardType;
  final bool isPassword;
  const CustomInput(
      {super.key,
      required this.icon,
      required this.placeholder,
      required this.textController,
      this.keyboardType = TextInputType.text,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 231, 228, 228),
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]),
      child: TextField(
        controller: textController,
        autocorrect: false,
        keyboardType: keyboardType,
        //* Poner tipo password ***********
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          // Quitar la linea cuando esta en focu, osea cuando esta abierto el input
          focusedBorder: InputBorder.none,
          // Quitar la linea del input
          border: InputBorder.none,
          hintText: placeholder,
        ),
      ),
    );
  }
}
