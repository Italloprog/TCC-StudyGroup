import 'dart:ui';
import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {

  const CardInfo({super.key, required this.titulo, required this.conteudo, required this.icone, required this.cor});

  final String titulo;
  final String conteudo;
  final IconData icone;
  final Color cor;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 58, 17, 89),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: cor.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: cor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icone, color: cor, size: 28),
              const SizedBox(width: 10),
              Text(
                titulo,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: cor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            conteudo,
            style: const TextStyle(fontSize: 16, color: Colors.white, height: 1.4),
          ),
        ],
      ),
    );
  } 
}