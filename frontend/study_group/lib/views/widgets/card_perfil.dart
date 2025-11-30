import 'package:flutter/material.dart';

class CardPerfil extends StatefulWidget {
  const CardPerfil({super.key, required this.nome_perfil, required this.pontos_perfil, required this.imagem_perfil,});

  final String nome_perfil;
  final int pontos_perfil;
  final String imagem_perfil;

  @override
  State<CardPerfil> createState() => _CardPerfilState();
}

class _CardPerfilState extends State<CardPerfil> {
  @override
  Widget build(BuildContext context) {
    return Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 116, 52, 184),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 19.5,
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(widget.imagem_perfil),radius: 50,),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.nome_perfil, style: TextStyle(fontSize: 20),),

                      Text('${widget.pontos_perfil} pontos', style: TextStyle(fontSize: 16, color: Colors.grey),),
                      
                      SizedBox(height:40,)
                    ],
                  ),

                  Spacer(),

                  TextButton(
                          onPressed: () {
                          Navigator.pushNamed(context, '/perfil');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 58, 17, 89),
                        ),
                        child: Text('ver detalhes'),
                      ),
                  
                ],
              ),
            );
  }
}