import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_group/controllers/gateways/grupo_gateway.dart';

class FirebaseGrupoRepository implements GrupoGateway {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> criarGrupo({
    required String nome,
    required String descricao,
    required String modoPontuacao,
    required String qtdDias,
    required File? imagem,
    required String criadorId,
    required String codigoConvite,
  }) async {
    String? fotoBase64;

    // Converte a imagem para Base64 usando a mesma lógica do perfil
    if (imagem != null) {
      final bytes = await imagem.readAsBytes();
      fotoBase64 = base64Encode(bytes);
    }

    // Salva o grupo em uma nova coleção chamada 'grupos'
    await _firestore.collection('grupos').add({
      'nome': nome,
      'descricao': descricao,
      'modoPontuacao': modoPontuacao,
      'qtdDias': qtdDias,
      'fotoGrupo': fotoBase64,
      'criadorId': criadorId,
      // Já adicionamos o criador como o primeiro membro e administrador!
      'membros': [criadorId], 
      'dataInicio': FieldValue.serverTimestamp(),
      'codigoConvite': codigoConvite,
    });
  }
}