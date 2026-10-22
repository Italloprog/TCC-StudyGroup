import 'dart:convert';

import 'package:flutter/material.dart';

class CardPodio extends StatefulWidget {
  const CardPodio({super.key, required this.nome_perfil, required this.pontos_perfil, required this.imagem_perfil, required this.colocacao, this.tamanho = 50});

  final String nome_perfil;
  final int pontos_perfil;
  final String imagem_perfil;
  final int colocacao;
  final double tamanho;

  @override
  State<CardPodio> createState() => _CardPodioState();
}

class _CardPodioState extends State<CardPodio> {
  @override
  Widget build(BuildContext context) {
    return Container(
              margin:  EdgeInsets.symmetric(horizontal: 25, vertical: widget.tamanho < 50 ? 5 : 10),
              padding:  EdgeInsets.all(widget.tamanho < 50 ? 5 :10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 116, 52, 184),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: widget.tamanho,
                    backgroundImage: (widget.imagem_perfil.isNotEmpty)
                      ? MemoryImage(base64Decode(widget.imagem_perfil)) // Transforma texto em imagem
                      : null,
            
                    child: (widget.imagem_perfil.isEmpty)
                      ? Icon(Icons.person, size: widget.tamanho)
                      : null,
                    ),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.nome_perfil, style: TextStyle(fontSize: 20),),

                      Text('${widget.pontos_perfil} pontos', style: TextStyle(fontSize: 16, color: Colors.grey),),
                    ],
                  ),

                  Text('${widget.colocacao}º', style: TextStyle(fontSize: 30),),
                  
                ],
              ),
            );
  }
}