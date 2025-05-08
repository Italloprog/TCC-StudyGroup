import 'package:flutter/material.dart';

class Botao extends StatefulWidget {
  const Botao({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  State<Botao> createState() => _BotaoState();
}

class _BotaoState extends State<Botao> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 58, 17, 89),
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 35),
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