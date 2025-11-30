import 'package:flutter/material.dart';

class CardPostagem extends StatefulWidget {
  const CardPostagem({super.key,required this.imagem, required this.titulo, required this.autor, required this.data});

  final String imagem;
  final String titulo;
  final String autor;
  final String data;

  @override
  State<CardPostagem> createState() => _CardPostagemState();
}

class _CardPostagemState extends State<CardPostagem> {
  @override
  Widget build(BuildContext context) {
    return Card(
            color: Color.fromARGB(255, 58, 17, 89),
            
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: InkWell(
              
              onTap: () {},
              child: ListTile(
                minVerticalPadding: 20,
                
                
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(widget.imagem),
                  radius: 40,
                ),
                
                title: Text(
                  widget.titulo,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  widget.autor,
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Text(widget.data, style: TextStyle(fontSize: 14,color: Colors.white),),
              ),
            ),
            
          );
  }
}