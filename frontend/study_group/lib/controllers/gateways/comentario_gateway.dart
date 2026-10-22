abstract class ComentarioGateway {
  Future<void> adicionarComentario({
    required String idGrupo,
    required String idPostagem,
    required String texto,
    required String autorId,
    required String autorNome,
    required String? autorFotoBase64,
  });

  Future<List<Map<String, dynamic>>> buscarComentarios(String idGrupo, String idPostagem);

  Future<void> excluirComentario(String idGrupo, String idPostagem, String idComentario);
}