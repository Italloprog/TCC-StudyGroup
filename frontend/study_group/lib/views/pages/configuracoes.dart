import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/autenticacao_controller.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/campo_imagem.dart';
import 'package:study_group/views/widgets/campo_texto.dart';
import 'package:study_group/views/widgets/scafolld_base.dart';
import 'package:study_group/views/widgets/texto_com_linha.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  File? _imagem;
  TextEditingController BiografiaController = TextEditingController();
  TextEditingController SenhaController = TextEditingController();
  TextEditingController ConfirmarSenhaController = TextEditingController();

  Future<void> _pegarImagemDaGaleria() async {
    final XFile? imagemSelecionada = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imagemSelecionada != null) {
      setState(() {
        _imagem = File(imagemSelecionada.path);
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return ScafolldBase(
      title: 'Configurações',
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10, bottom: 10),
    
        child: SafeArea(
          child: Column(
            spacing: 10,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              Row(children: [SizedBox(width: 20,),TextoComLinha(texto: 'Alterar imagem de perfil',),],),

              CampoImagem(),

              Row(children: [SizedBox(width: 20,),TextoComLinha(texto: 'Alterar biografia'),],),
              
              CampoTexto(controller: BiografiaController,hint: 'Digite sua nova biografia...',),
        
              Botao(
                label: 'confirmar',
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Biografia alterada com sucesso!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                padding_v: 15,
              ),
        
              Row(children: [SizedBox(width: 20,),TextoComLinha(texto: 'Alterar senha'),],),
              
        
              CampoTexto(controller: SenhaController,campoSenha: true,hint: 'Digite sua nova senha...',),
              CampoTexto(controller: ConfirmarSenhaController,campoSenha: true,hint: 'Confirme sua nova senha...',),
        
              Botao(
                label: 'confirmar',
                 onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Senha alterada com sucesso!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                 },
                  padding_v: 15,
                  ),
        
              Row(children: [SizedBox(width: 20,),TextoComLinha(texto: 'Excluir conta'),],),
        
              Botao(
                label: 'excluir', 
                onPressed: () async {
                  // É MUITO importante perguntar antes de excluir!
                  bool confirmar = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Tem certeza?'),
                      content: const Text('Esta ação apagará todos os seus dados e não pode ser desfeita.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Excluir', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  ) ?? false;

                  if (confirmar && context.mounted) {
                    final sucesso = await context.read<AutenticacaoController>().apagarConta();
                    
                    if (sucesso && context.mounted) {
                      // Limpa a pilha de navegação e joga para o login
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                    } else if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Erro ao excluir. Tente fazer login novamente e repita o processo.')),
                      );
                    }
                  }
                }, 
                padding_v: 15
              ),
        
              Row(children: [SizedBox(width: 20,),TextoComLinha(texto: 'Sair da conta'),],),

              Botao(
                label: 'sair', 
                onPressed: () async {
                  bool confirmar = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Tem certeza?'),
                      content: const Text('Após sair, você precisará fazer login novamente para acessar sua conta.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Sair', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  ) ?? false;

                  if (!confirmar || !context.mounted) return;
                  final sucesso = await context.read<AutenticacaoController>().sairDaConta();
                  
                  if (sucesso && context.mounted) {
                    // Limpa a pilha de navegação e joga para o login
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                  }
                }, 
                padding_v: 15
              ),
            ],
          ),
        ),
      )
      
    );
  }
}