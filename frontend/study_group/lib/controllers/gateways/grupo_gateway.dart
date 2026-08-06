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
}