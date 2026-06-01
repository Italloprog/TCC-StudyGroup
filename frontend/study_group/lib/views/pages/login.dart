import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/autenticacao_controller.dart';
import 'package:study_group/views/widgets/Icone_grande_app.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/campo_texto.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AutenticacaoController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  'Bem-vindo ao StudyGroup',
                  style: TextStyle(fontSize: 20),
                ),
                IconeGrandeApp(),
                SizedBox(
                  height: 20,
                ),
                CampoTexto(controller: _emailController, label: 'EMAIL', hint: 'Seu email...',),
                CampoTexto(
                  controller: _senhaController,
                  label: 'SENHA',
                  hint: 'Sua senha...',
                  campoSenha: true,
                ),
                SizedBox(
                  height: 90,
                ),
                authController.isLoading
                    ? const CircularProgressIndicator() // Mostra o loading enquanto carrega
                    : Botao(
                        label: 'LOGIN',
                        onPressed: () async {
                          final sucesso = await context.read<AutenticacaoController>().realizarLogin(_emailController.text,_senhaController.text,);
        
                          if (sucesso && context.mounted) {
                            Navigator.pushReplacementNamed(context, '/pagina_inicial');
                          } else if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Falha ao fazer login. Verifique seus dados.')),
                            );
                          }
                        },
                      ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/cadastro');
                  },
                  child: Text(
                    'CADASTRE-SE',
                    style: TextStyle(
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 2.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
