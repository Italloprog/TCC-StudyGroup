import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_group/controllers/gateways/grupo_gateway.dart';
import 'package:study_group/controllers/gateways/postagem_gateway.dart';
import 'package:study_group/controllers/repositories/firebase/grupo_repository.dart';
import 'package:study_group/controllers/repositories/firebase/postagem_repository.dart';

class GrupoController extends ChangeNotifier {
  final GrupoGateway grupoGateway = FirebaseGrupoRepository();
  final PostagemGateway postagemGateway = FirebasePostagemRepository();

  bool isLoading = false;

  // Variável que vai guardar os dados para as telas lerem
  Map<String, dynamic>? dadosGrupo;
  String? idGrupoAtual; // Guarda o ID do grupo atual para facilitar a navegação

  List<Map<String, dynamic>> postagens = [];
  List<Map<String, dynamic>> classificacao = [];
  List<Map<String, dynamic>> membrosDetalhes = [];

  void setIdGrupoAtual(String id) {
    idGrupoAtual = id;
    notifyListeners();
  }

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

  Future<bool> editarGrupo({
    required String groupId,
    required String nome,
    required String descricao,
    required String modoPontuacao,
    required String qtdDias,
    required File? novaImagem,
  }) async {
    
    if (nome.isEmpty || descricao.isEmpty) {
      throw Exception("Preencha o nome e a descrição do grupo.");
    }

    isLoading = true;
    notifyListeners();

    try {
      await grupoGateway.editarGrupo(
        groupId: groupId,
        nome: nome.trim(),
        descricao: descricao.trim(),
        modoPontuacao: modoPontuacao,
        qtdDias: qtdDias,
        novaImagem: novaImagem,
      );

      // Atualiza a variável local em memória para a tela anterior já mostrar o novo nome/descrição
      if (dadosGrupo != null) {
        dadosGrupo!['nome'] = nome.trim();
        dadosGrupo!['descricao'] = descricao.trim();
        dadosGrupo!['modoPontuacao'] = modoPontuacao;
        dadosGrupo!['qtdDias'] = qtdDias;
        
        if (novaImagem != null) {
           final bytes = await novaImagem.readAsBytes();
           dadosGrupo!['fotoGrupo'] = base64Encode(bytes);
        }
      }

      return true;
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao editar grupo: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> carregarClassificacao() async {
    isLoading = true;
    notifyListeners();

    try {
      classificacao = await grupoGateway.buscarClassificacao(idGrupoAtual!);
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao carregar classificação: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> carregarMembrosDoGrupo() async {
    // Se o grupo não estiver carregado ou não tiver membros, não faz nada
    if (dadosGrupo == null || dadosGrupo!['membros'] == null) return;
    
    try {
      List<dynamic> ids = dadosGrupo!['membros'];
      membrosDetalhes = await grupoGateway.buscarMembros(ids);
      notifyListeners(); // Atualiza a tela quando a lista de membros chegar
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao carregar lista de membros: $e");
    }
  }

  Future<void> buscarDadosGrupo(String idGrupo) async {
    isLoading = true;
    notifyListeners();

    try {
      final resultados = await Future.wait([
        grupoGateway.buscarDadosGrupo(idGrupo),
        postagemGateway.buscarPostagensGrupo(idGrupo),
      ]);
      
      dadosGrupo = resultados[0] as Map<String, dynamic>?;
      postagens = resultados[1] as List<Map<String, dynamic>>;

    } catch (e) {
      // ignore: avoid_print
      print("Erro ao buscar dados do grupo: $e");
      dadosGrupo = null;
      postagens = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Retorna uma String nula se falhar, ou o ID do grupo se der certo
  Future<String?> entrarNoGrupo(String codigoConvite) async {
    if (codigoConvite.isEmpty) {
      throw Exception("Digite o código de convite.");
    }

    User? usuarioLogado = FirebaseAuth.instance.currentUser;
    if (usuarioLogado == null) {
      throw Exception("Sessão expirada. Faça login novamente.");
    }

    isLoading = true;
    notifyListeners();

    try {
      // Remove espaços em branco que o usuário possa ter digitado sem querer
      String codigoLimpo = codigoConvite.trim();
      
      String idDoGrupo = await grupoGateway.entrarNoGrupoPorCodigo(codigoLimpo, usuarioLogado.uid);
      
      return idDoGrupo;
    } catch (e) {
      // Repassa o erro (sem a palavra Exception) para mostrar no Snackbar
      throw Exception(e.toString().replaceAll("Exception: ", ""));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> sairDoGrupo() async {
    User? usuarioLogado = FirebaseAuth.instance.currentUser;
    if (usuarioLogado == null) {
      throw Exception("Sessão expirada. Faça login novamente.");
    }

    isLoading = true;
    notifyListeners();

    try {
      await grupoGateway.removerDoGrupo(idGrupoAtual!, usuarioLogado.uid);
      return true;
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao sair do grupo: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> retirarDoGrupo(String idUsuario) async {
    isLoading = true;
    notifyListeners();

    try {
      await grupoGateway.removerDoGrupo(idGrupoAtual!, idUsuario);
      await buscarDadosGrupo(idGrupoAtual!); // Atualiza os dados do grupo após a remoção
      await carregarMembrosDoGrupo(); // Atualiza a lista de membros após a remoção
      return true;
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao retirar usuario do grupo: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}