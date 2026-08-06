import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_group/controllers/gateways/usuario_gateway.dart';

class FirebaseUsuarioRepository implements UsuarioGateway {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Map<String, dynamic>?> buscarDadosUsuario(String uid) async {
    try {
      // Vai na coleção 'users', procura o documento com o ID do usuário logado
      final snapshot = await _firestore.collection('users').doc(uid).get();
      
      if (snapshot.exists) {
        return snapshot.data();
      }
      return null;
    } catch (e) {
      // ignore: avoid_print
      print("Erro ao buscar dados do usuário: $e");
      rethrow;
    }
  }
  
  @override
  Future<void> alterarBiografia(String uid, String novaBiografia) async {
    
    try {
      // Atualiza o campo 'biografia' do documento do usuário
      await _firestore.collection('users').doc(uid).update({
        'biografia': novaBiografia,
      });

    } catch (e) {
      // ignore: avoid_print
      print("Erro ao alterar biografia: $e");
      rethrow;
    }
  }

  @override
  Future<void> alterarFotoPerfil(String uid, File novaFoto) async {
    
    try {
      // Converte a imagem para Base64
      final bytes = novaFoto.readAsBytesSync();
      final fotoBase64 = base64Encode(bytes);

      // Atualiza o campo 'fotoPerfil' do documento do usuário
      await _firestore.collection('users').doc(uid).update({
        'fotoPerfil': fotoBase64,
      });

    } catch (e) {
      // ignore: avoid_print
      print("Erro ao alterar foto de perfil: $e");
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> pesquisarUsuarios(String termoDeBusca) async {
    if (termoDeBusca.isEmpty) return [];

    try {
      // O truque do Firestore para buscar por strings que começam com o termo
      // O '\uf8ff' é um caractere Unicode muito alto, que funciona como limite da busca
      final snapshot = await _firestore
          .collection('users')
          .where('nome', isGreaterThanOrEqualTo: termoDeBusca)
          .where('nome', isLessThanOrEqualTo: '$termoDeBusca\uf8ff')
          .get();

      // Mapeia os documentos encontrados e embute o ID (uid) dentro do mapa
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['uid'] = doc.id; // Essencial para depois abrirmos o perfil completo
        return data;
      }).toList();
    } catch (e) {
      print("Erro ao pesquisar usuários: $e");
      return [];
    }
  }
}