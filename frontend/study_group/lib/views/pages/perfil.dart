import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/usuario_controller.dart';
import 'package:study_group/views/widgets/scafolld_base.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key, this.indexPesquisado});

  final int? indexPesquisado;

  @override
  Widget build(BuildContext context) {
    final usuarioController = context.watch<UsuarioController>();

    String areaMaisEstudada() {  
      if(usuarioController.dadosUsuario?['qtdPostExatas'] > usuarioController.dadosUsuario?['qtdPostHumanas'] &&
     usuarioController.dadosUsuario?['qtdPostExatas'] > usuarioController.dadosUsuario?['qtdPostLinguagens'] &&
      usuarioController.dadosUsuario?['qtdPostExatas'] > usuarioController.dadosUsuario?['qtdPostSaude'] &&
       usuarioController.dadosUsuario?['qtdPostExatas'] > usuarioController.dadosUsuario?['qtdPostSociais']){
      return 'Exatas';
      } else if(usuarioController.dadosUsuario?['qtdPostHumanas'] > usuarioController.dadosUsuario?['qtdPostExatas'] &&
     usuarioController.dadosUsuario?['qtdPostHumanas'] > usuarioController.dadosUsuario?['qtdPostLinguagens'] &&
      usuarioController.dadosUsuario?['qtdPostHumanas'] > usuarioController.dadosUsuario?['qtdPostSaude'] &&
       usuarioController.dadosUsuario?['qtdPostHumanas'] > usuarioController.dadosUsuario?['qtdPostSociais']){
      return 'Humanas';
      } else if(usuarioController.dadosUsuario?['qtdPostLinguagens'] > usuarioController.dadosUsuario?['qtdPostExatas'] &&
     usuarioController.dadosUsuario?['qtdPostLinguagens'] > usuarioController.dadosUsuario?['qtdPostHumanas'] &&
      usuarioController.dadosUsuario?['qtdPostLinguagens'] > usuarioController.dadosUsuario?['qtdPostSaude'] &&
       usuarioController.dadosUsuario?['qtdPostLinguagens'] > usuarioController.dadosUsuario?['qtdPostSociais']){
      return 'Linguagens';
      } else if(usuarioController.dadosUsuario?['qtdPostSaude'] > usuarioController.dadosUsuario?['qtdPostExatas'] &&
     usuarioController.dadosUsuario?['qtdPostSaude'] > usuarioController.dadosUsuario?['qtdPostHumanas'] &&
      usuarioController.dadosUsuario?['qtdPostSaude'] > usuarioController.dadosUsuario?['qtdPostLinguagens'] &&
       usuarioController.dadosUsuario?['qtdPostSaude'] > usuarioController.dadosUsuario?['qtdPostSociais']){
      return 'Saúde';
      } else if(usuarioController.dadosUsuario?['qtdPostSociais'] > usuarioController.dadosUsuario?['qtdPostExatas'] &&
     usuarioController.dadosUsuario?['qtdPostSociais'] > usuarioController.dadosUsuario?['qtdPostHumanas'] &&
      usuarioController.dadosUsuario?['qtdPostSociais'] > usuarioController.dadosUsuario?['qtdPostLinguagens'] &&
       usuarioController.dadosUsuario?['qtdPostSociais'] > usuarioController.dadosUsuario?['qtdPostSaude']){
        return 'Sociais';
      }
      return 'Diversas áreas';
    }
    
    String classificacaoUsuario() {
      int totalPontos = 0;

      if(indexPesquisado != null){
        totalPontos = usuarioController.resultadosPesquisa[indexPesquisado!]['totalPontos'];
      }else{
        totalPontos = usuarioController.dadosUsuario?['totalPontos'] ?? 0;
      }
      
      if (totalPontos < 500) {
        return 'Estudante Iniciante📚';
      } else if (totalPontos < 1000) {
        return 'Estudante Focado🔎';
      } else if (totalPontos < 1700) {
        return 'Estudante Avançado🧠';
      } else if (totalPontos < 2800) {
        return 'Estudante Superior🎒';
      } else if (totalPontos < 4500) {
        return 'Estudante Mestre👨‍🏫';
      } else if (totalPontos < 7000) {
        return 'Estudante Doutor👨‍⚕️';
      } else if (totalPontos < 9000) {
        return 'Estudante Divino☯';
      } else if (totalPontos < 11000) {
        return 'Estudante Cósmico✨';
      } else if (totalPontos < 15000) {
        return 'Estudante da Nasa🪐';
      } else {
        return 'Estudante Oniciente🤓';
      }
    }

    return ScafolldBase(
      title: 'Perfil',
      body: Center(
        
        child: Column(
          
          children: [
            const SizedBox(height: 15),
            CircleAvatar(
              radius: 80,
              backgroundImage: indexPesquisado != null ? 
                          usuarioController.resultadosPesquisa[indexPesquisado!]['fotoPerfil'] != null 
                            ? MemoryImage(base64Decode(usuarioController.resultadosPesquisa[indexPesquisado!]['fotoPerfil']))
                            : null
                          : usuarioController.dadosUsuario?['fotoPerfil'] != null
                            ? MemoryImage(base64Decode(usuarioController.dadosUsuario?['fotoPerfil']))
                            : null,
              child: (indexPesquisado == null && usuarioController.dadosUsuario?['fotoPerfil'] == null) || (indexPesquisado != null && usuarioController.resultadosPesquisa[indexPesquisado!]['fotoPerfil'] == null)
                      ? const Icon(Icons.person, size: 90)
                      : null,
            ),

            const SizedBox(height: 20),

            Text(
              indexPesquisado != null ? usuarioController.resultadosPesquisa[indexPesquisado!]['nome'] :
              usuarioController.dadosUsuario?['nome'] ?? 'Nome do Usuário',
              style: TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: 320,
              child: Text(
                indexPesquisado != null ? usuarioController.resultadosPesquisa[indexPesquisado!]['biografia'] :
                usuarioController.dadosUsuario?['biografia'] ?? 'Nenhuma biografia encontrada.',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                  Text('Quantia de pontos total:\n${indexPesquisado != null ? usuarioController.resultadosPesquisa[indexPesquisado!]['totalPontos'] : usuarioController.dadosUsuario?['totalPontos'] ?? '0'} pontos', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 217, 217, 217),), textAlign: TextAlign.center ,),
                  Spacer()
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
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
                  Text('Maior ofensiva: ${indexPesquisado != null ? usuarioController.resultadosPesquisa[indexPesquisado!]['maiorOfensiva'] : usuarioController.dadosUsuario?['maiorOfensiva'] ?? '0'} dias', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 217, 217, 217),), textAlign: TextAlign.center ,),
                  Spacer()
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
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
                  Text('Classificação:\n${classificacaoUsuario()}', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 217, 217, 217),), textAlign: TextAlign.center ,),
                  Spacer()
                ],
              ),
            ),
            
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
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
                  Text('Área mais estudada:\n${areaMaisEstudada()}', style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 217, 217, 217),), textAlign: TextAlign.center ,),
                  Spacer()
                ],
              ),
            )
          ],
        ),),
    );
  }
}