import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_group/controllers/gateways/autenticacao_gateway.dart';
import 'package:study_group/controllers/repositories/firebase/autenticacao_repository.dart';

class AutenticacaoController extends ChangeNotifier {
  final AutenticacaoGateway authGateway = AutenticacaoRepository();
  bool isLoading = false;

  // Retorna true se o login der certo, false se falhar
  Future<bool> realizarLogin(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      if (email.isEmpty || password.isEmpty) throw Exception("Preencha todos os campos.");
      await authGateway.login(email.trim(), password.trim());
      return true;
    } catch (e) {
      // ignore: avoid_print
      print("Erro no login: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Retorna true se o cadastro der certo
  Future<bool> realizarCadastro(String nome, String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      if (nome.isEmpty || email.isEmpty || password.isEmpty) {
        throw Exception("Preencha todos os campos.");
      }
      await authGateway.register(nome.trim(), email.trim(), password.trim());
      return true;
    } catch (e) {
      // ignore: avoid_print
      print("Erro no cadastro: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> sairDaConta() async {
    isLoading = true;
    notifyListeners();

    try {
      await authGateway.logout();
      return true;
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao fazer logoff: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> apagarConta() async {
    isLoading = true;
    notifyListeners();

    try {
      await authGateway.deleteAccount();
      return true;
    } on FirebaseAuthException catch (e) {
      // O Firebase exige que o usuário tenha logado recentemente para excluir a conta.
      // Se ele estiver logado há muito tempo, esse erro será disparado.
      if (e.code == 'requires-recent-login') {
        print("O usuário precisa fazer login novamente antes de excluir a conta.");
      }
      // ignore: avoid_print
      print("Erro ao excluir conta: $e");
      return false;
    } catch (e) {
      // ignore: avoid_print
      print("Erro geral ao excluir conta: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}