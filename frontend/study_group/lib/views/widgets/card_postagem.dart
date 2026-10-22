import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_group/views/pages/postagem.dart';

class CardPostagem extends StatefulWidget {
  const CardPostagem({super.key,required this.imagem, required this.titulo, required this.autor, required this.data, required this.indexPostagem});

  final String imagem;
  final String titulo;
  final String autor;
  final int indexPostagem;
  final Timestamp data;

  @override
  State<CardPostagem> createState() => _CardPostagemState();
}

class _CardPostagemState extends State<CardPostagem> {
  @override
  Widget build(BuildContext context) {
    return Card(
            color: Color.fromARGB(255, 58, 17, 89),
            
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(22),
              onTap: () {
                Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context) => PostagemPage(indexPostagem: widget.indexPostagem),
                                  ),
                                );
              },
              child: ListTile(
                minVerticalPadding: 20,
                
                leading: CircleAvatar(
                    radius: 40,
                    backgroundImage: MemoryImage(base64Decode(widget.imagem))
                    ), // Transforma texto em imagem
       
                title: Text(
                  widget.titulo,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, height: 1),
                ),

                subtitle: Text(
                  widget.autor,
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Text(DateFormat('d MMM','pt_BR').format(widget.data.toDate()).toLowerCase(), style: TextStyle(fontSize: 14,color: Colors.white),),
              ),
            ),
            
          );
  }
}