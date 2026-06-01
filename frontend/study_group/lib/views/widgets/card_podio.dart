import 'package:flutter/material.dart';

class CardPodio extends StatefulWidget {
  const CardPodio({super.key, required this.nome_perfil, required this.pontos_perfil, required this.imagem_perfil, required this.colocacao,});

  final String nome_perfil;
  final int pontos_perfil;
  final String imagem_perfil;
  final int colocacao;

  @override
  State<CardPodio> createState() => _CardPodioState();
}

class _CardPodioState extends State<CardPodio> {
  @override
  Widget build(BuildContext context) {
    return Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 116, 52, 184),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(widget.imagem_perfil),radius: 50,),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.nome_perfil, style: TextStyle(fontSize: 20),),

                      Text('${widget.pontos_perfil} pontos', style: TextStyle(fontSize: 16, color: Colors.grey),),
                    ],
                  ),

                  IconButton(onPressed: (){}, icon: Icon(Icons.delete), color: Colors.white,iconSize: 30,),

                  Text('${widget.colocacao}º', style: TextStyle(fontSize: 30),),
                  
                ],
              ),
            );
  }
}