import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 30, right: 30),
        child: Column(
          spacing: 10,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              spacing: 50,
              children: [
                TextoComLinha(texto: 'Alterar imagem de perfil',),
                CampoImagem(),
              ],
            ),
            
            Row(
              children: [TextoComLinha(texto: 'Alterar biografia'),],
            ),
            
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

            Row(children: [TextoComLinha(texto: 'Alterar senha'),],),
            

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

            Row(children: [TextoComLinha(texto: 'Excluir conta'),],),

            Botao(label: 'excluir', onPressed: (){Navigator.pushNamed(context, '/login');}, padding_v: 15),

            Row(children: [TextoComLinha(texto: 'Sair da conta'),],),
            Botao(label: 'sair', onPressed: (){Navigator.pushNamed(context, '/login'); }, padding_v: 15),
          ],
        ),
      )
      
    );
  }
}