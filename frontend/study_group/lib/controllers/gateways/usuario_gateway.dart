import 'dart:io';

abstract class UsuarioGateway {
  // Retorna um Map com os dados do usuário, ou null se não encontrar
  Future<Map<String, dynamic>?> buscarDadosUsuario(String uid);

  Future<List<Map<String, dynamic>>> buscarMeusGrupos(String uid);

  Future<void> alterarBiografia(String uid, String novaBiografia);

  Future<void> alterarFotoPerfil(String uid, File novaFoto);

  Future<List<Map<String, dynamic>>> pesquisarUsuarios(String termoDeBusca);
}