import 'package:flutter/material.dart';

class IconeGrandeApp extends StatelessWidget {
  const IconeGrandeApp({super.key, this.altura, this.largura});
  final double? altura;
  final double? largura;

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: const EdgeInsets.all(10),
            width: largura ?? 200,
            height: altura ?? 200,
            child: ClipOval(
              child: Image.asset('lib/assets/iconeApp2.png'),
            ),
          );
  }
}