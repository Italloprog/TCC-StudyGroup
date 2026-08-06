import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_group/controllers/gateways/grupo_gateway.dart';
import 'package:study_group/controllers/repositories/firebase/grupo_repository.dart';

class GrupoController extends ChangeNotifier {
  final GrupoGateway grupoGateway = FirebaseGrupoRepository();
  bool isLoading = false;

  String _gerarCodigoConvite() {
    const caracteres = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random rnd = Random();
    
    // Gera uma string de 6 caracteres sorteando os valores da constante acima
    return String.fromCharCodes(
      Iterable.generate(
        6, (_) => caracteres.codeUnitAt(rnd.nextInt(caracteres.length))
      ),
    );
  }

  Future<bool> criarGrupo({
    required String nome,
    required String descricao,
    required String modoPontuacao,
    required String qtdDias,
    required File? imagem,
  }) async {
    // Validações básicas
    if (nome.isEmpty || descricao.isEmpty) {
      throw Exception("Preencha o nome e a descrição do grupo.");
    }
    
    if (modoPontuacao == "Modo de pontuação" || qtdDias == "Quantidade de dias") {
      throw Exception("Selecione o modo de pontuação e a duração.");
    }

    User? usuarioLogado = FirebaseAuth.instance.currentUser;
    if (usuarioLogado == null) {
      throw Exception("Usuário não autenticado.");
    }

    isLoading = true;
    notifyListeners();

    try {
      await grupoGateway.criarGrupo(
        nome: nome.trim(),
        descricao: descricao.trim(),
        modoPontuacao: modoPontuacao,
        qtdDias: qtdDias,
        imagem: imagem,
        criadorId: usuarioLogado.uid,
        codigoConvite: _gerarCodigoConvite(),
      );
      return true; //Sucesso
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao criar grupo: $e");
      return false; // Falha
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}