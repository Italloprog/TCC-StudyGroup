import 'package:flutter/material.dart';
import 'package:study_group/views/widgets/Icone_grande_app.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/scafolld_base.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  @override
  Widget build(BuildContext context) {
    return ScafolldBase(
      body: Column(
        children: [
          
          IconeGrandeApp(),

          const SizedBox(
            height: 20,
          ),

          Text('Você ainda não participa de nenhum grupo',style: TextStyle(fontSize: 20),),
          const SizedBox(
            height: 60,
          ),
          Botao(label: 'Criar novo grupo', onPressed: (){
            Navigator.pushNamed(context, '/novo_grupo');
          }),
          const SizedBox(
            height: 20,
          ),
          Botao(label: 'Entrar em grupo existente', onPressed: (){
            Navigator.pushNamed(context, '/encontrar_grupo');
          })
        ],
      )
    );
  }
}