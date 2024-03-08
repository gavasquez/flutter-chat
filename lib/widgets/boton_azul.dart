import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const BotonAzul({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(5),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          shape:
              MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder())),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
