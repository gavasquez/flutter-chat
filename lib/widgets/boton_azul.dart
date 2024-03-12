import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const BotonAzul({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(2),
          shape: MaterialStateProperty.all(const StadiumBorder())),
      // elevation: 2,
      // highlightElevation: 5,
      // color: Colors.blue,
      // shape: StadiumBorder(),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(text,
              style: const TextStyle(color: Colors.white, fontSize: 17)),
        ),
      ),
    );
  }
}
