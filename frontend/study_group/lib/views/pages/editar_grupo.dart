import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/campo_selecao.dart';
import 'package:study_group/views/widgets/campo_texto.dart';
import 'package:study_group/views/widgets/grande_campo_imagem.dart';
import 'package:study_group/views/widgets/scafolld_arrowback.dart';

class EditarGrupoPage extends StatefulWidget {
  const EditarGrupoPage({super.key});

  @override
  State<EditarGrupoPage> createState() => _EditarGrupoPageState();
}

class _EditarGrupoPageState extends State<EditarGrupoPage> {
  File? _imagem;
  final TextEditingController nomeGrupoController = TextEditingController();
  final TextEditingController descricaoGrupoController = TextEditingController();
  String selectedModoPontuacao = "Modo de pontuação";
  String selectedQtdDias = "Quantidade de dias";

  Future<void> _pegarImagemDaGaleria() async {
    // A mágica da compressão acontece aqui
    final XFile? imagemSelecionada = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70, // Reduz a qualidade da imagem para 70%
      maxWidth: 400,    // Reduz a largura máxima
      maxHeight: 400,   // Reduz a altura máxima
    );

    if (imagemSelecionada != null) {
      setState(() {
        _imagem = File(imagemSelecionada.path);
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return ScafolldArrowback(
        title: 'Editar Grupo',
        body: SingleChildScrollView(
          child: Column(
          children: [
            GrandeCampoImagem(label: 'Imagem do grupo', onpressed: _pegarImagemDaGaleria, imagem: _imagem),
            CampoTexto(
              controller: nomeGrupoController,
              label: 'NOME DO GRUPO',
              hint: 'Digite o nome do grupo...',
            ),
            CampoTexto(
              controller: descricaoGrupoController,
              label: 'DESCRIÇÃO',
              hint: 'Descreva o grupo...',
              extendido: true,
            ),
            SizedBox(height: 20),
            CampoSelecao(
              selected: selectedModoPontuacao,
              opcoes: ['Pontos por Atividade', 'Pontos por Dias Ativos'],
              onChanged: (value) {
                setState(() {
                  selectedModoPontuacao = value;
                });
              },
            ),
            SizedBox(height: 20),
            CampoSelecao(
              selected: selectedQtdDias,
              opcoes: ['10 dias', '20 dias', '30 dias', '40 dias', '60 dias'],
              onChanged: (value) {
                setState(() {
                  selectedQtdDias = value;
                });
              },
            ),
            SizedBox(height: 20),

            Botao(label: 'Editar grupo', onPressed: () {Navigator.pushNamed(context, '/grupo');},),

            SafeArea(child: Container()), // Garante que o conteúdo não fique atrás da barra de navegação
          ],
                ),
        ),
      ) ;
      
  }
}