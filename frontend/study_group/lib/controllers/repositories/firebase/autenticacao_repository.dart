import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_group/controllers/gateways/autenticacao_gateway.dart';

class AutenticacaoRepository implements AutenticacaoGateway {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> register(String nome, String email, String password) async {
    // 1. Cria o usuário no Firebase Auth
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // 2. Salva os dados adicionais (como o nome) no Firestore usando o UID do Auth
    if (credential.user != null) {
      await _firestore.collection('users').doc(credential.user!.uid).set({
        'nome': nome,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'biografia': 'Sou novo por aqui!',
        'totalPontos': 0,
        'ofensivaAtual': 0,
        'maiorOfensiva': 0,
        'qtdPostHumanas': 0,
        'qtdPostExatas': 0,
        'qtdPostSociais': 0,
        'qtdPostSaude': 0,
        'qtdPostLinguagens': 0,
      });
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    User? user = _auth.currentUser;
    
    if (user != null) {
      // É uma boa prática deletar os dados do usuário no Firestore antes de excluir a conta
      await _firestore.collection('users').doc(user.uid).delete();
      
      // Deleta o usuário do Firebase Auth
      await user.delete();
    } else {
      throw Exception("Nenhum usuário logado encontrado.");
    }
  }
}