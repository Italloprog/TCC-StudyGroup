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
    final DocumentReference grupoRef = await _firestore.collection('grupos').add({
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

    String idGrupo = grupoRef.id;

    await _firestore
        .collection('grupos')
        .doc(idGrupo)
        .collection('ranking') // Cria a subcoleção de ranking
        .doc(criadorId) // Usa o ID do usuário como documento
        .set({
            'pontos': 0,
        }, SetOptions(merge: true)); 
  }

  @override
  Future<void> editarGrupo({
    required String groupId,
    required String nome,
    required String descricao,
    required String modoPontuacao,
    required String qtdDias,
    required File? novaImagem,
  }) async {
    // 1. Prepara o mapa de dados que serão atualizados
    Map<String, dynamic> dadosParaAtualizar = {
      'nome': nome,
      'descricao': descricao,
      'modoPontuacao': modoPontuacao,
      'qtdDias': qtdDias,
    };

    // 2. Se o usuário escolheu uma nova foto, converte para Base64 e adiciona ao mapa
    if (novaImagem != null) {
      final bytes = await novaImagem.readAsBytes();
      dadosParaAtualizar['fotoGrupo'] = base64Encode(bytes);
    }

    // 3. Atualiza apenas os campos fornecidos no documento do grupo
    await _firestore.collection('grupos').doc(groupId).update(dadosParaAtualizar);
  }

  @override
  Future<Map<String, dynamic>> buscarDadosGrupo(String idGrupo) {

    return _firestore.collection('grupos').doc(idGrupo).get().then((doc) {
      if (doc.exists) {
        return doc.data()!;
      } else {
        throw Exception("Grupo não encontrado");
      }
    });
    
  }

  @override
  Future<String> entrarNoGrupoPorCodigo(String codigoConvite, String usuarioId) async {
    // 1. Faz uma busca (query) para encontrar um grupo que tenha esse código exato
    final query = await _firestore
        .collection('grupos')
        .where('codigoConvite', isEqualTo: codigoConvite)
        .limit(1)
        .get();

    // 2. Se a busca voltar vazia, o código não existe
    if (query.docs.isEmpty) {
      throw Exception("Código de convite inválido ou grupo não encontrado.");
    }

    // 3. Pega o documento do grupo encontrado
    final docGrupo = query.docs.first;
    final String groupId = docGrupo.id;

    // 4. Usa o arrayUnion para adicionar o usuário à lista de membros de forma segura.
    // Se o usuário já estiver na lista, o Firebase é inteligente o suficiente para não duplicar.
    await _firestore.collection('grupos').doc(groupId).update({
      'membros': FieldValue.arrayUnion([usuarioId])
    });

    await _firestore
        .collection('grupos')
        .doc(groupId)
        .collection('ranking') // Cria a subcoleção de ranking
        .doc(usuarioId) // Usa o ID do usuário como documento
        .set({
            'pontos': 0,
        }, SetOptions(merge: true)); 

    // 5. Retorna o ID do grupo para a tela poder fazer a navegação
    return groupId;
  }

  @override
  Future<void> removerDoGrupo(String groupId, String usuarioId) async {
    final docRef = _firestore.collection('grupos').doc(groupId);
    final docSnap = await docRef.get();

    if (!docSnap.exists) {
      throw Exception("Grupo não encontrado.");
    }

    final dados = docSnap.data()!;
    List<dynamic> membros = dados['membros'] ?? [];
    String donoId = dados['criadorId'];

    // Cenario 3: É o dono e é o último membro do grupo
    if (membros.length == 1 && membros.contains(usuarioId)) {
      // Deleta o grupo inteiro para não deixar "lixo" no banco
      await docRef.delete();
      return;
    }

    // Cenario 2: É o dono saindo, mas tem mais gente no grupo
    if (donoId == usuarioId) {
      // Pega a primeira pessoa da lista que não seja o próprio dono que está saindo
      String novoDono = membros.firstWhere((id) => id != usuarioId);
      
      await docRef.update({
        'membros': FieldValue.arrayRemove([usuarioId]), // Remove o antigo dono
        'criadorId': novoDono, // Passa a coroa para o novo dono
      });
    } 
    // Cenario 1: É apenas um membro comum saindo
    else {
      await docRef.update({
        'membros': FieldValue.arrayRemove([usuarioId]),
      });
    }
  }

  @override
  Future<List<Map<String, dynamic>>> buscarClassificacao(String idGrupo) async {
    try {
      // 1. Busca na subcoleção 'ranking' ordenando pelos 'pontos' de forma decrescente
      final snapshot = await _firestore
          .collection('grupos')
          .doc(idGrupo)
          .collection('ranking')
          .orderBy('pontos', descending: true)
          .get();

      List<Map<String, dynamic>> listaRanking = [];

      // 2. Para cada membro no ranking, buscamos o Nome e Foto atuais na coleção 'users'
      for (var doc in snapshot.docs) {
        final dadosRanking = doc.data();
        final String userId = doc.id;

        final userDoc = await _firestore.collection('users').doc(userId).get();
        if (userDoc.exists) {
          dadosRanking['nome'] = userDoc.data()!['nome'];
          dadosRanking['fotoPerfil'] = userDoc.data()!['fotoPerfil'];
          dadosRanking['idUsuario'] = userDoc.id; // Adiciona o ID do usuário para referência
        }

        listaRanking.add(dadosRanking);
      }

      return listaRanking;
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao buscar classificação: $e");
      return [];
    }
  }

  @override
  Future<List<Map<String, dynamic>>> buscarMembros(List<dynamic> idsMembros) async {
    List<Map<String, dynamic>> lista = [];
    try {
      // Fazemos um loop para buscar o perfil de cada membro lá na coleção 'users'
      for (String id in idsMembros) {
        final doc = await _firestore.collection('users').doc(id).get();
        if (doc.exists) {
          final dados = doc.data()!;
          dados['uid'] = doc.id; // Guarda o ID para usarmos no CardMembro
          lista.add(dados);
        }
      }
      return lista;
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao buscar membros do grupo: $e");
      return [];
    }
  }

}