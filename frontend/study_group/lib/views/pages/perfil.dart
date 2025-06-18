import 'package:flutter/material.dart';
import 'package:study_group/views/widgets/scafolld_base.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScafolldBase(
      title: 'Perfil',
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 15),
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage('https://pbs.twimg.com/media/FsGrGIBXgAA1OQI.jpg'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nome do Usuário',
              style: TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 15),

            const SizedBox(
              width: 380,
              child: Text(
                'Pequena biografia descritiva e personalizavel escrita pelo usuario de no maximo 100 caracteres.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: 380,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 10),

              decoration: BoxDecoration(
                
                border: Border.all(
                  color: const Color.fromARGB(255, 116, 52, 184),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(25),
              ),

              child: Row(
                
                children: [
                  Icon(Icons.auto_stories,color: const Color.fromARGB(255, 217, 217, 217), size: 34,),
                  Spacer(),
                  Text('Quantia de pontos total:\n10 pontos', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 217, 217, 217),), textAlign: TextAlign.center ,),
                  Spacer()
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 380,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 10),

              decoration: BoxDecoration(
                
                border: Border.all(
                  color: const Color.fromARGB(255, 116, 52, 184),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(25),
              ),

              child: Row(
                
                children: [
                  Icon(Icons.local_fire_department,color: const Color.fromARGB(255, 217, 217, 217), size: 34,),
                  Spacer(),
                  Text('Maior ofensiva: 5 dias ', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 217, 217, 217),), textAlign: TextAlign.center ,),
                  Spacer()
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 380,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 10),

              decoration: BoxDecoration(
                
                border: Border.all(
                  color: const Color.fromARGB(255, 116, 52, 184),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(25),
              ),

              child: Row(
                
                children: [
                  Icon(Icons.school,color: const Color.fromARGB(255, 217, 217, 217), size: 34,),
                  Spacer(),
                  Text('Classificação:\nEstudante iniciante', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 217, 217, 217),), textAlign: TextAlign.center ,),
                  Spacer()
                ],
              ),
            ),
             Container(
              margin: const EdgeInsets.only(top: 10),
              width: 380,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 10),

              decoration: BoxDecoration(
                
                border: Border.all(
                  color: const Color.fromARGB(255, 116, 52, 184),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(25),
              ),

              child: Row(
                
                children: [
                  Icon(Icons.bookmark_added,color: const Color.fromARGB(255, 217, 217, 217), size: 34,),
                  Spacer(),
                  Text('Área mais estudada:\nMatemática', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 217, 217, 217),), textAlign: TextAlign.center ,),
                  Spacer()
                ],
              ),
            )
          ],
        ),),
    );
  }
}