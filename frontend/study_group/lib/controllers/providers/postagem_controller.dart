import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_group/controllers/gateways/postagem_gateway.dart';
import 'package:study_group/controllers/repositories/firebase/postagem_repository.dart';

class PostagemController extends ChangeNotifier {
  final PostagemGateway postagemGateway = FirebasePostagemRepository();

  bool isLoading = false;

  Future<bool> criarPostagem({
    required String groupId,
    required String titulo,
    required String descricao,
    required String tempoEstudo,
    required String areaEstudo,
    required File imagem,
    required String autorNome,
    required String autorFotoBase64,
  }) async {
    
    if (titulo.isEmpty || descricao.isEmpty) {
      throw Exception("Preencha o título e a descrição.");
    }

    if (tempoEstudo == "Tempo de estudo" || areaEstudo == "Área de estudo") {
      throw Exception("Selecione o tempo e a área de estudo.");
    }

    User? usuarioLogado = FirebaseAuth.instance.currentUser;
    if (usuarioLogado == null) {
      throw Exception("Usuário não autenticado.");
    }

    isLoading = true;
    notifyListeners();

    try {
      await postagemGateway.criarPostagem(
        groupId: groupId,
        titulo: titulo.trim(),
        descricao: descricao.trim(),
        tempoEstudo: tempoEstudo,
        areaEstudo: areaEstudo,
        imagem: imagem,
        autorId: usuarioLogado.uid,
        autorNome: autorNome,
        autorFotoBase64: autorFotoBase64,
      );

      return true;
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao criar postagem: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> excluirPostagem(String idGrupo, String idPostagem) async{
    isLoading = true;
    notifyListeners();

    try {
      await postagemGateway.excluirPostagem(idGrupo, idPostagem);

      return true;
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao excluir postagem: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}