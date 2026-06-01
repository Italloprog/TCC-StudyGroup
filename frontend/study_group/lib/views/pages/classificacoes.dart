import 'package:flutter/material.dart';
import 'package:study_group/views/widgets/card_podio.dart';
import 'package:study_group/views/widgets/scafolld_arrowback.dart';

class ClassificacoesPage extends StatefulWidget {
  const ClassificacoesPage({super.key});

  @override
  State<ClassificacoesPage> createState() => _ClassificacoesPageState();
}

class _ClassificacoesPageState extends State<ClassificacoesPage> {
  @override
  Widget build(BuildContext context) {
    return ScafolldArrowback(
      title: 'Classificações',
      egrupo: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardPodio(nome_perfil: 'Pessoa 1', pontos_perfil: 55, imagem_perfil: 'https://pbs.twimg.com/media/FsGrGIBXgAA1OQI.jpg', colocacao: 1),
            CardPodio(nome_perfil: 'Pessoa 2', pontos_perfil: 40, imagem_perfil: 'https://pbs.twimg.com/media/FSOGBy3XsAIxTiN.png', colocacao: 2),
            CardPodio(nome_perfil: 'Pessoa 3', pontos_perfil: 30, imagem_perfil: 'https://64.media.tumblr.com/0f7f8ecbb9df092d53582bf230e6e550/027836647fc0de15-c7/s1280x1920/830a5f592dd22d55f6d5f9210dec70fa8f32bb85.jpg', colocacao: 3),
            CardPodio(nome_perfil: 'Pessoa 4', pontos_perfil: 20, imagem_perfil: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_fF60wLcJobL2nXnwxFtoSql0EKCXoTBjZQ&s', colocacao: 4),
            
            SafeArea(child: Container()), // Garante que o conteúdo não fique atrás da barra de navegação
          ],
        ),
      ),
      );
  }
}