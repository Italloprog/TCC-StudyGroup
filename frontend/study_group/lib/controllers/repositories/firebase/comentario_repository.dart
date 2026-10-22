import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_group/controllers/gateways/comentario_gateway.dart';

class FirebaseComentarioRepository implements ComentarioGateway {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> adicionarComentario({
    required String idGrupo,
    required String idPostagem,
    required String texto,
    required String autorId,
    required String autorNome,
    required String? autorFotoBase64,
  }) async {

    await _firestore
        .collection('grupos')
        .doc(idGrupo)
        .collection('postagens')
        .doc(idPostagem)
        .collection('comentarios')
        .add({
      'texto': texto,
      'autorId': autorId,
      'autorNome': autorNome,
      'autorFotoBase64': autorFotoBase64,
      'createdAt': FieldValue.serverTimestamp(),
    });
    
  }

  @override
  Future<void> excluirComentario(String idGrupo, String idPostagem, String idComentario) async {
    try {
      await _firestore
          .collection('grupos')
          .doc(idGrupo)
          .collection('postagens')
          .doc(idPostagem)
          .collection('comentarios')
          .doc(idComentario)
          .delete();
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao excluir comentário no Firebase: $e");
      throw Exception("Não foi possível excluir o comentário.");
    }
  }

  @override
  Future<List<Map<String, dynamic>>> buscarComentarios(String idGrupo, String idPostagem) async {
    try {
      final snapshot = await _firestore
          .collection('grupos')
          .doc(idGrupo)
          .collection('postagens')
          .doc(idPostagem)
          .collection('comentarios')
          .orderBy('createdAt', descending: false) // Do mais antigo pro mais novo (padrão de chat)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['idComentario'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao buscar comentários: $e");
      return [];
    }
  }
}