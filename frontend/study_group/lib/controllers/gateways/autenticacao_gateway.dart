import 'dart:io';

abstract class AutenticacaoGateway {
  // Retorna um fluxo que diz 'true' se estiver logado e 'false' se não estiver
  Stream<bool> get statusSessao;
  Future<void> login(String email, String password);
  Future<void> register(String nome, String email, String password, File? fotoPerfil);
  Future<void> logout();
  Future<void> deleteAccount();
  Future<void> alterarSenha(String novaSenha);
}