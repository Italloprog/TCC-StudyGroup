import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_group/controllers/gateways/postagem_gateway.dart';

class FirebasePostagemRepository implements PostagemGateway {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Map<String, dynamic>>> buscarPostagensGrupo(String idGrupo) async {
    try {
      // AQUI ESTÁ O SEGREDO: Navegamos até a subcoleção 'postagens'
      // O orderBy garante que as postagens mais novas apareçam primeiro no topo!
      final snapshot = await _firestore
          .collection('grupos')
          .doc(idGrupo)
          .collection('postagens')
          .orderBy('createdAt', descending: true) 
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['idPostagem'] = doc.id; // Guarda o ID da postagem caso precise excluir depois
        return data;
      }).toList();

    } catch (e) {
      // ignore: avoid_print
      print("Erro ao buscar postagens: $e");
      return [];
    }
  }

  @override
  Future<QuerySnapshot> buscarUltimasPostagens(String userId) async {
      return await _firestore
        .collectionGroup('postagens')
        .where('autorId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(7)
        .get(); 
  }

  @override
  Future<void> criarPostagem({
    required String groupId,
    required String titulo,
    required String descricao,
    required String tempoEstudo,
    required String areaEstudo,
    required File imagem,
    required String autorId,
    required String autorNome,
    required String autorFotoBase64, // Adicionado para armazenar a foto do autor
  }) async {
    String fotoBase64;

    // Transforma a imagem em Base64
    final bytes = await imagem.readAsBytes();
    fotoBase64 = base64Encode(bytes);

    final int qtdPontos = int.tryParse(RegExp(r'\d+').firstMatch(tempoEstudo)?.group(0) ?? '0')! * 2;
    
    // Acessa o grupo, cria a subcoleção 'postagens' e adiciona o documento
    await _firestore
        .collection('grupos')
        .doc(groupId)
        .collection('postagens')
        .add({
      'titulo': titulo,
      'descricao': descricao,
      'tempoEstudo': tempoEstudo,
      'areaEstudo': areaEstudo,
      'imagemBase64': fotoBase64,
      'autorId': autorId,
      'autorNome': autorNome,
      'createdAt': FieldValue.serverTimestamp(),
      'qtdPontos': qtdPontos,
      'autorFotoBase64': autorFotoBase64, // Salva a foto do autor junto com a postagem
    });

    await _firestore.collection('users').doc(autorId).update({
      'totalPontos': FieldValue.increment(qtdPontos),
    });

    if(areaEstudo == "Exatas") {
      await _firestore.collection('users').doc(autorId).update({
        'qtdPostExatas': FieldValue.increment(1),
      });
    } else if(areaEstudo == "Humanas") {
      await _firestore.collection('users').doc(autorId).update({
        'qtdPostHumanas': FieldValue.increment(1),
      });
    } else if(areaEstudo == "Linguagens") {
      await _firestore.collection('users').doc(autorId).update({
        'qtdPostLinguagens': FieldValue.increment(1),
      });
    } else if(areaEstudo == "Saúde") {
      await _firestore.collection('users').doc(autorId).update({
        'qtdPostSaude': FieldValue.increment(1),
      });
    } else if(areaEstudo == "Sociais") {
      await _firestore.collection('users').doc(autorId).update({
        'qtdPostSociais': FieldValue.increment(1),
      });
    }

    // 3. NOVO: Salva os pontos exclusivamente no ranking deste grupo!
    await _firestore
        .collection('grupos')
        .doc(groupId)
        .collection('ranking') // Cria a subcoleção de ranking
        .doc(autorId) // Usa o ID do usuário como documento
        .set({
            'pontos': FieldValue.increment(qtdPontos),
        }, SetOptions(merge: true)); // O merge garante que se o doc já existir, ele só soma; se não existir, ele cria!

  }

  @override
  Future<void> excluirPostagem(String idGrupo, String idPostagem) async {
    
    final docRef = _firestore.collection('grupos').doc(idGrupo).collection('postagens').doc(idPostagem);
    final docSnap = await docRef.get();

    if (!docSnap.exists) {
      throw Exception("Postagem não encontrada.");
    }

    final dadosPostagem = docSnap.data();

    final String autorId = dadosPostagem?['autorId'];
    final int qtdPontos = dadosPostagem?['qtdPontos'];
    final String areaEstudo = dadosPostagem?['areaEstudo'];

    if (autorId.isEmpty) return;
    // Atualiza os pontos do usuário
    await _firestore.collection('users').doc(autorId).update({
      'totalPontos': FieldValue.increment(-qtdPontos),
    });

    // Atualiza a contagem de postagens por área
    if(areaEstudo == "Exatas") {
      await _firestore.collection('users').doc(autorId).update({
        'qtdPostExatas': FieldValue.increment(-1),
      });
    } else if(areaEstudo == "Humanas") {
      await _firestore.collection('users').doc(autorId).update({
        'qtdPostHumanas': FieldValue.increment(-1),
      });
    } else if(areaEstudo == "Linguagens") {
      await _firestore.collection('users').doc(autorId).update({
        'qtdPostLinguagens': FieldValue.increment(-1),
      });
    } else if(areaEstudo == "Saúde") {
      await _firestore.collection('users').doc(autorId).update({
        'qtdPostSaude': FieldValue.increment(-1),
      });
    } else if(areaEstudo == "Sociais") {
      await _firestore.collection('users').doc(autorId).update({
        'qtdPostSociais': FieldValue.increment(-1),
      });
    }

    // Atualiza os pontos no ranking do grupo
    await _firestore.collection('grupos').doc(idGrupo).collection('ranking').doc(autorId)
        .update({
            'pontos': FieldValue.increment(-qtdPontos),
        });

    await docRef.delete();
    return;
  }

}