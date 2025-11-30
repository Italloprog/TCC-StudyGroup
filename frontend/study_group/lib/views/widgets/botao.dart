import 'package:flutter/material.dart';

class Botao extends StatefulWidget {
  const Botao({super.key, required this.label, required this.onPressed, this.padding_h = 60,this.padding_v = 35});

  final String label;
  final VoidCallback onPressed;
  final double padding_h;
  final double padding_v;

  @override
  State<Botao> createState() => _BotaoState();
}

class _BotaoState extends State<Botao> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 58, 17, 89),
        padding: EdgeInsets.symmetric(horizontal: widget.padding_h, vertical: widget.padding_v),
      ),
      onPressed: widget.onPressed,
      child: Text(
        widget.label,
        style: const TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),

    );
  }
}