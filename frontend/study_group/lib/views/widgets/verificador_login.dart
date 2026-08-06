import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/autenticacao_controller.dart';
import 'package:study_group/views/pages/login.dart';
import 'package:study_group/views/pages/pagina_inicial.dart';

class VerificadorAutenticacao extends StatelessWidget {
  const VerificadorAutenticacao({super.key});

  @override
  Widget build(BuildContext context) {
    // Pegamos o controller usando read() pois o StreamBuilder já vai "escutar" as mudanças
    final authController = context.read<AutenticacaoController>();

    return StreamBuilder<bool>(
      stream: authController.statusSessao,
      builder: (context, snapshot) {
        // Enquanto o Firebase pensa, mostramos um carregamento
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Verifica o que o Firebase respondeu
        final estaLogado = snapshot.data ?? false;

        if (estaLogado) {
          // Usuário tem sessão salva! Vai direto para a Home.
          return const PaginaInicial(); 
        } else {
          // Não tem sessão. Vai para a tela de Login.
          return const LoginPage(); 
        }
      },
    );
  }
}