import 'package:flutter/material.dart';
import 'package:study_group/views/widgets/scafolld_base.dart';

class SobrePage extends StatefulWidget {
  const SobrePage({super.key});

  @override
  State<SobrePage> createState() => _SobrePageState();
}

class _SobrePageState extends State<SobrePage> {
  @override
  Widget build(BuildContext context) {
    return ScafolldBase(
      title: 'Sobre',
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            Text('Olá estudantes!', style: TextStyle(fontSize: 24),),
            SizedBox(height: 20,),
            Text('O objetivo deste aplicativo é atuar como um motivador social para o hábito de estudar. Seja para um desafio individual ou em grupo.', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20,),
            Text('Bons estudos!', style: TextStyle(fontSize: 18),),
            Spacer(),
            Text('Aplicação desenvolvida e idealizada por Itallo Aleandro e orientada pelo Prof. Rogério Silva para o trabalho de conclusão de curso de ADS do IFPI.', style: TextStyle(fontSize: 18,)),
            Spacer(),
          ],
        ),
      ),
    );
  }
}