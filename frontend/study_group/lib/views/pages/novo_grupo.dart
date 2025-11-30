import 'package:flutter/material.dart';
import 'package:study_group/views/widgets/Icone_grande_app.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/scafolld_base.dart';

class NovoGrupoPage extends StatefulWidget {
  const NovoGrupoPage({super.key});

  @override
  State<NovoGrupoPage> createState() => _NovoGrupoPageState();
}

class _NovoGrupoPageState extends State<NovoGrupoPage> {
  @override
  Widget build(BuildContext context) {
    return ScafolldBase(
      title: 'Criar novo grupo',
      body: Column(
        children: [
          IconeGrandeApp(),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 400,
            
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
                
              border: Border.all(
                color: const Color.fromARGB(255, 116, 52, 184),
                width: 3,
              ),
              borderRadius: BorderRadius.circular(25),
            ),

            child: Text('Detalhes:\nUm grupo de estudos com data de início e término.\nOs membros participam e competem dentro do prazo para alcançar o topo do ranking.', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 217, 217, 217), ), textAlign: TextAlign.center,),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 60),
            width: 400,
            
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
                
              border: Border.all(
                color: const Color.fromARGB(255, 116, 52, 184),
                width: 3,
              ),
              borderRadius: BorderRadius.circular(25),
            ),

            child: Text('Modos de pontuação:\nDias ativos ou pontos por atividade. ', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 217, 217, 217), ), textAlign: TextAlign.center,),
          ),
          
          Botao(label: 'Criar novo grupo', onPressed: (){ Navigator.pushNamed(context, '/criar_grupo');},),
        ],
      ),
    );
  }
}