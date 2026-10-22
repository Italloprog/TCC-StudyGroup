import 'dart:io';

abstract class GrupoGateway {

  Future<void> criarGrupo({
    required String nome,
    required String descricao,
    required String modoPontuacao,
    required String qtdDias,
    required File? imagem,
    required String criadorId, // Precisamos saber quem criou!
    required String codigoConvite,
  });

  Future<void> editarGrupo({
    required String groupId,
    required String nome,
    required String descricao,
    required String modoPontuacao,
    required String qtdDias,
    required File? novaImagem, // Opcional: só preenche se ele escolheu outra
  });

  Future<Map<String, dynamic>> buscarDadosGrupo(String idGrupo);

  // Retornará o ID do grupo (document ID) para podermos navegar para a tela dele
  Future<String> entrarNoGrupoPorCodigo(String codigoConvite, String usuarioId);

  Future<void> removerDoGrupo(String groupId, String usuarioId);

  Future<List<Map<String, dynamic>>> buscarClassificacao(String idGrupo);

  // Recebe a lista de IDs e devolve a lista de dados dos usuários
  Future<List<Map<String, dynamic>>> buscarMembros(List<dynamic> idsMembros);
}