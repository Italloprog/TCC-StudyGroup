import 'package:flutter/material.dart';

class TextoComLinha extends StatelessWidget {
  const TextoComLinha({super.key, required this.texto});
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(texto,
            style: TextStyle(
              fontSize: 20,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
              decorationThickness: 1.0,
            )),
      ],
    );
  }
}