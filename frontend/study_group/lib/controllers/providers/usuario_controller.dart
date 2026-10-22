import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_group/controllers/gateways/usuario_gateway.dart';
import 'package:study_group/controllers/repositories/firebase/usuario_repository.dart';

class UsuarioController extends ChangeNotifier {
  final UsuarioGateway usuarioGateway = FirebaseUsuarioRepository();
  bool isLoading = true;

  // Variável que vai guardar os dados para as telas lerem
  Map<String, dynamic>? dadosUsuario;
  List<Map<String, dynamic>> gruposUsuario = [];

  Map<String, dynamic>? dadosUsuarioPesquisado;
  List<Map<String, dynamic>> resultadosPesquisa = [];
  
  // Função para carregar os dados assim que o usuário logar
  Future<void> carregarPerfil() async {
    isLoading = true;
    notifyListeners();
    // O notifyListeners() aqui avisa a tela para mostrar o "loading"
    // Use com moderação se chamar no initState, ou faça o agendamento pós-frame.
    // Para simplificar, mudamos o estado em silêncio se for a primeira carga
    
    try {
      // Pega o ID do usuário que está logado no momento
      User? usuarioLogado = FirebaseAuth.instance.currentUser;
      
      if (usuarioLogado != null) {
        
        // Busca os dados do perfil E a lista de grupos em paralelo para ser mais rápido
        final resultados = await Future.wait([
          // Busca os dados no Firestore através do Gateway
          usuarioGateway.buscarDadosUsuario(usuarioLogado.uid),
          usuarioGateway.buscarMeusGrupos(usuarioLogado.uid),
        ]);

        dadosUsuario = resultados[0] as Map<String, dynamic>?;
        gruposUsuario = resultados[1] as List<Map<String, dynamic>>;
      }
    } catch (e) {
      // ignore: avoid_print
      print("Erro no controller ao carregar perfil: $e");
    } finally {
      isLoading = false;
      notifyListeners(); // Avisa a interface que os dados chegaram
    }
  }

  Future<void> carregarPerfilPesquisado(String userId) async {
    isLoading = true;
    notifyListeners();
    // O notifyListeners() aqui avisa a tela para mostrar o "loading"
    // Use com moderação se chamar no initState, ou faça o agendamento pós-frame.
    // Para simplificar, mudamos o estado em silêncio se for a primeira carga
  
    try {
      // Busca os dados no Firestore através do Gateway
      dadosUsuarioPesquisado = await usuarioGateway.buscarDadosUsuario(userId);
      
    } catch (e) {
      // ignore: avoid_print
      print("Erro no controller ao carregar perfil pesquisado: $e");
    } finally {
      isLoading = false;
      notifyListeners(); // Avisa a interface que os dados chegaram
    }
  }

  // Função para limpar a memória quando o usuário fizer logoff
  void limparDados() {
    dadosUsuario = null;
    gruposUsuario = []; // Limpa os grupos também no logoff
    notifyListeners();
  }

  Future<bool> alterarBiografia(String novaBiografia) async {
    isLoading = true;
    notifyListeners();

    try {
      User? usuarioLogado = FirebaseAuth.instance.currentUser;
      if (usuarioLogado != null) {
        await usuarioGateway.alterarBiografia(usuarioLogado.uid, novaBiografia);
        // Atualiza os dados locais após a alteração
        await carregarPerfil();
      }
      return true;
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao alterar biografia: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> alterarFotoPerfil(File novaFoto) async {
    isLoading = true;
    notifyListeners();

    try {
      User? usuarioLogado = FirebaseAuth.instance.currentUser;
      if (usuarioLogado != null) {
        await usuarioGateway.alterarFotoPerfil(usuarioLogado.uid, novaFoto);
        // Atualiza os dados locais após a alteração
        await carregarPerfil();
      }
      return true;
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao alterar foto de perfil: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> pesquisar(String termo) async {

    if (termo.isEmpty) {
      resultadosPesquisa = [];
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      resultadosPesquisa = await usuarioGateway.pesquisarUsuarios(termo);
    } catch (e) {
      // ignore: avoid_print
      print("Erro no controller de pesquisa: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  
}