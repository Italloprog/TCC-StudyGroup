import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_group/controllers/gateways/ai_gateway.dart';
import 'package:study_group/controllers/infrastructure/ai_infrastructure.dart';

class AIController extends ChangeNotifier {
  final AiGateway aiGateway = AiInfrastructure();
  
  bool isLoading = false;
  Map<String, dynamic>? analiseGerada;

  Future<void> gerarAnalise() async {
    User? usuarioLogado = FirebaseAuth.instance.currentUser;
    if (usuarioLogado == null) return;

    isLoading = true;
    analiseGerada = null; // Limpa a anterior
    notifyListeners();

    try {
      analiseGerada = await aiGateway.analisarUltimasPostagens(usuarioLogado.uid);
    } catch (e) {
      // ignore: avoid_print
      print("Erro: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}