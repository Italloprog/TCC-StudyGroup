import 'package:flutter/material.dart';
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
          
          Container(
            margin: const EdgeInsets.all(10),
            width: 200,
            height: 200,
            child: ClipOval(
              child: Image.asset('lib/assets/iconeApp2.png'),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          Text('Você ainda não participa de nenhum grupo',style: TextStyle(fontSize: 20),),
          const SizedBox(
            height: 60,
          ),
          Botao(label: 'Criar novo grupo', onPressed: (){}),
          const SizedBox(
            height: 20,
          ),
          Botao(label: 'Entrar em grupo existente', onPressed: (){})
        ],
      )
    );
  }
}