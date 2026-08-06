import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:study_group/views/pages/perfil.dart';

class CardPerfil extends StatefulWidget {
  const CardPerfil({super.key, required this.nome_perfil, required this.pontos_perfil, this.imagem_perfil, required this.indexPesquisado});

  final String nome_perfil;
  final int pontos_perfil;
  final String? imagem_perfil;
  final int indexPesquisado;

  @override
  State<CardPerfil> createState() => _CardPerfilState();
}

class _CardPerfilState extends State<CardPerfil> {
  @override
  Widget build(BuildContext context) {
    return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 116, 52, 184),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: (widget.imagem_perfil != null && widget.imagem_perfil!.isNotEmpty)
                      ? MemoryImage(base64Decode(widget.imagem_perfil!)) // Transforma texto em imagem
                      : null,
            
                    child: (widget.imagem_perfil == null || widget.imagem_perfil!.isEmpty)
                      ? const Icon(Icons.person, size: 50)
                      : null,
                    ),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.nome_perfil, style: TextStyle(fontSize: 20),),

                      Text('${widget.pontos_perfil} pontos', style: TextStyle(fontSize: 16, color: Colors.grey),),
                      
                      SizedBox(height:40,)
                    ],
                  ),


                  TextButton(
                          onPressed: () {
                          Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context) => PerfilPage(indexPesquisado: widget.indexPesquisado,),
                                  ),
                                );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 58, 17, 89),
                        ),
                        child: Text('ver perfil', style: TextStyle(fontSize: 14),),
                      ),
                  
                ],
              ),
            );
  }
}