import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/campo_selecao.dart';
import 'package:study_group/views/widgets/campo_texto.dart';
import 'package:study_group/views/widgets/grande_campo_imagem.dart';
import 'package:study_group/views/widgets/scafolld_arrowback.dart';

class NovaPostagemPage extends StatefulWidget {
  const NovaPostagemPage({super.key});

  @override
  State<NovaPostagemPage> createState() => _NovaPostagemPageState();
}

class _NovaPostagemPageState extends State<NovaPostagemPage> {
  File? _imagem;
  final TextEditingController tituloPostagemController = TextEditingController();
  final TextEditingController descricaoPostagemController = TextEditingController();
  var selectedTempoDeEstudo = "Tempo de estudo";
  var selectedAreaDeEstudo = "Área de estudo";

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
        title: 'Nova Postagem',
        body: SingleChildScrollView(
          child: Column(
            children: [
              GrandeCampoImagem(label: 'Imagem da Postagem', onpressed: _pegarImagemDaGaleria, imagem: _imagem),
              CampoTexto(controller: tituloPostagemController, label: 'TÍTULO', hint: 'Digite o título da postagem...',),
              CampoTexto(controller: descricaoPostagemController, label: 'DESCRIÇÃO', hint: 'Digite a descrição da postagem...', extendido: true,),
              SizedBox(height: 20),
              CampoSelecao(selected: selectedTempoDeEstudo, opcoes: ['15 minutos', '30 minutos', '45 minutos', '60 minutos','75 minutos', '90 minutos', '115 minutos', '120 minutos'],
                onChanged: (value) {
                  setState(() {
                    selectedTempoDeEstudo = value;
                  });
                },
              ),
              SizedBox(height: 20),
              CampoSelecao(selected: selectedAreaDeEstudo,
               opcoes: ['Matemática', 'Quimica', 'História', 'Geografia', 'Física', 'Biologia', 'Linguas', 'Artes', 'Sociologia', 'Filosofia', 'Tecnologia', 'Outros'],
                onChanged: (value) {
                  setState(() {
                    selectedAreaDeEstudo = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Botao(label: 'Adicionar', onPressed: (){Navigator.pushNamed(context, '/grupo');},),
              SafeArea(child: Container()), // Garante que o conteúdo não fique atrás da barra de navegação
            ],
          ),
        )
    );
  }
}