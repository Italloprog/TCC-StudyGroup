import 'package:flutter/material.dart';
import 'package:study_group/controllers/gateways/comentario_gateway.dart';
import 'package:study_group/controllers/repositories/firebase/comentario_repository.dart';

class ComentarioController extends ChangeNotifier {
  final ComentarioGateway comentarioGateway = FirebaseComentarioRepository();

  bool isLoading = false;
  List<Map<String, dynamic>> comentarios = [];

  Future<void> carregarComentarios(String idGrupo, String idPostagem) async {
    isLoading = true;
    notifyListeners();

    try {
      comentarios = await comentarioGateway.buscarComentarios(idGrupo, idPostagem);
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao carregar comentarios: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> excluirComentario(String idGrupo, String idPostagem, String idComentario) async {

    isLoading = true;
    notifyListeners();

    try {
      // 1. Apaga do banco de dados
      await comentarioGateway.excluirComentario(idGrupo, idPostagem, idComentario);
      
      await carregarComentarios(idGrupo, idPostagem);
      
      return true;
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao excluir comentário: $e");
      return false;

    }finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> adicionarComentario({
    required String idGrupo,
    required String idPostagem,
    required String texto,
    required String autorId,
    required String autorNome,
    required String? autorFotoBase64,
  }) async {
    
    if (texto.trim().isEmpty) return false;

    // Não ativamos o isLoading aqui para não fazer a tela inteira piscar.
    // Vamos apenas enviar pro banco e recarregar a lista silenciosamente.
    
    try {
      await comentarioGateway.adicionarComentario(
        idGrupo: idGrupo,
        idPostagem: idPostagem,
        texto: texto.trim(),
        autorId: autorId,
        autorNome: autorNome,
        autorFotoBase64: autorFotoBase64,
      );
      
      // Recarrega a lista para mostrar o novo comentário imediatamente
      await carregarComentarios(idGrupo, idPostagem);
      return true;
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao adicionar comentário: $e");
      return false;
    }
  }
}