import 'package:flutter/material.dart';
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
  final TextEditingController tituloPostagemController = TextEditingController();
  final TextEditingController descricaoPostagemController = TextEditingController();
  var selectedTempoDeEstudo = "Tempo de estudo";
  var selectedAreaDeEstudo = "Área de estudo";

  @override
  Widget build(BuildContext context) {
    return ScafolldArrowback(
        title: 'Nova Postagem',
        body: Column(
          children: [
            GrandeCampoImagem(label: 'Imagem da Postagem'),
            CampoTexto(controller: tituloPostagemController, label: 'TÍTULO',),
            CampoTexto(controller: descricaoPostagemController, label: 'DESCRIÇÃO', extendido: true,),
            SizedBox(height: 20),
            CampoSelecao(selected: selectedTempoDeEstudo, opcoes: ['15 minutos', '30 minutos', '45 minutos', '60 minutos','75 minutos', '90 minutos', '115 minutos', '120 minutos']),
            SizedBox(height: 20),
            CampoSelecao(selected: selectedAreaDeEstudo, opcoes: ['Matemática', 'Quimica', 'História', 'Geografia', 'Física', 'Biologia', 'Linguas', 'Artes', 'Sociologia', 'Filosofia', 'Tecnologia', 'Outros']),
            Spacer(),
            Botao(label: 'Adicionar', onPressed: (){Navigator.pushNamed(context, '/grupo');},),
            Spacer(),
          ],
        )
    );
  }
}