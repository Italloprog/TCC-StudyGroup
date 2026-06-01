import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/autenticacao_controller.dart';
import 'package:study_group/views/widgets/Icone_grande_app.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/campo_imagem.dart';
import 'package:study_group/views/widgets/campo_texto.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  File? _imagem;
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController =
      TextEditingController();

  Future<void> _pegarImagemDaGaleria() async {
    final XFile? imagemSelecionada =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imagemSelecionada != null) {
      setState(() {
        _imagem = File(imagemSelecionada.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AutenticacaoController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Text(
                      'Cadastrar-se',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    IconeGrandeApp(
                      altura: 120,
                      largura: 120,
                    ),
                  ],
                ),
                Text(
                  'IMAGEM DE PERFIL',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                CampoImagem(),
                SizedBox(
                  height: 10,
                ),
                CampoTexto(controller: _nomeController, label: 'NOME', hint: 'Seu nome...',),
                CampoTexto(controller: _emailController, label: 'EMAIL', hint: 'Seu email...',),
                CampoTexto(
                  controller: _senhaController,
                  label: 'SENHA',
                  hint: 'Sua senha...',
                  campoSenha: true,
                ),
                CampoTexto(
                  controller: _confirmaSenhaController,
                  label: 'CONFIRMAR SENHA',
                  hint: 'Confirme sua senha...',
                  campoSenha: true,
                ),
                SizedBox(
                  height: 25,
                ),
                authController.isLoading
                    ? const CircularProgressIndicator()
                    : Botao(
                        label: 'CRIAR CONTA',
                        onPressed: () async {
                          // Validação básica de senhas
                          if (_senhaController.text !=
                              _confirmaSenhaController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('As senhas não coincidem!')),
                            );
                            return;
                          }
        
                          final sucesso = await context
                              .read<AutenticacaoController>()
                              .realizarCadastro(
                                _nomeController.text,
                                _emailController.text,
                                _senhaController.text,
                              );
        
                          if (sucesso && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Conta criada com sucesso!')),
                            );
                            // Volta para a tela de login
                            Navigator.pop(context);
                          } else if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Erro ao criar conta.')),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 10),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}