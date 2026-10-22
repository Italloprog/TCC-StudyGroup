import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PostagemGateway {

  Future<List<Map<String, dynamic>>> buscarPostagensGrupo(String idGrupo);

  Future<void> criarPostagem({
    required String groupId,
    required String titulo,
    required String descricao,
    required String tempoEstudo,
    required String areaEstudo,
    required File imagem,
    required String autorId,
    required String autorNome, // Salvar o nome do autor evita termos que buscar no banco de usuários depois!
    required String autorFotoBase64, // Salvar a foto do autor evita termos que buscar no banco de usuários depois!
  });
  
  Future<void> excluirPostagem(String idGrupo, String idPostagem,);

  Future<QuerySnapshot> buscarUltimasPostagens(String userId);

}