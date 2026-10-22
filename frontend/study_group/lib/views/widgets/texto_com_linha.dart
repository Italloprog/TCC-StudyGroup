import 'package:flutter/material.dart';

class TextoComLinha extends StatelessWidget {
  const TextoComLinha({super.key, required this.texto, this.tamanho = 20});
  final String texto;
  final double tamanho;

  @override
  Widget build(BuildContext context) {
    return Text(texto,
            style: TextStyle(
              fontSize: tamanho,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
              decorationThickness: 1.0,
              ),
              
            );
  }
}