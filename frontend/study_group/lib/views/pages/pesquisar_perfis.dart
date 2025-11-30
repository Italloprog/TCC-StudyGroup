import 'package:flutter/material.dart';
import 'package:study_group/views/widgets/card_perfil.dart';
import 'package:study_group/views/widgets/scafolld_base.dart';

class PesquisarPerfisPage extends StatefulWidget {
  const PesquisarPerfisPage({super.key});

  @override
  State<PesquisarPerfisPage> createState() => _PesquisarPerfisPageState();
}

class _PesquisarPerfisPageState extends State<PesquisarPerfisPage> {
  final TextEditingController _perfisController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScafolldBase(
      title: 'Pesquisar perfis',
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
              child: TextFormField(
                controller: _perfisController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 116, 52, 184),
                  hintStyle: TextStyle(color: Color.fromARGB(200, 0, 0, 0)),
                  prefixIconColor: Color.fromARGB(255, 0, 0, 0),
                  hintText: 'Digite o nome...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
            ),

            CardPerfil(nome_perfil: 'Pessoa 1', pontos_perfil: 10, imagem_perfil: 'https://pbs.twimg.com/media/FsGrGIBXgAA1OQI.jpg',),
            CardPerfil(nome_perfil: 'Pessoa 2', pontos_perfil: 20, imagem_perfil: 'https://pbs.twimg.com/media/FSOGBy3XsAIxTiN.png',),
            CardPerfil(nome_perfil: 'Pessoa 3', pontos_perfil: 30, imagem_perfil: 'https://64.media.tumblr.com/0f7f8ecbb9df092d53582bf230e6e550/027836647fc0de15-c7/s1280x1920/830a5f592dd22d55f6d5f9210dec70fa8f32bb85.jpg',),
            CardPerfil(nome_perfil: 'Pessoa 4', pontos_perfil: 40, imagem_perfil: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_fF60wLcJobL2nXnwxFtoSql0EKCXoTBjZQ&s',),
            
          ],
        ),
      ),
    );
  }
}