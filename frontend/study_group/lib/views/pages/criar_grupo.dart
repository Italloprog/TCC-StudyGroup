import 'package:flutter/material.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/campo_selecao.dart';
import 'package:study_group/views/widgets/campo_texto.dart';
import 'package:study_group/views/widgets/grande_campo_imagem.dart';
import 'package:study_group/views/widgets/scafolld_base.dart';

class CriarGrupoPage extends StatefulWidget {
  const CriarGrupoPage({super.key});

  @override
  State<CriarGrupoPage> createState() => _CriarGrupoPageState();
}

class _CriarGrupoPageState extends State<CriarGrupoPage> {
  String selectedModoPontuacao = "Modo de pontuação";
  String selectedQtdDias = "Quantidade de dias";
  final TextEditingController nomeGrupoController = TextEditingController();
  final TextEditingController descricaoGrupoController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScafolldBase(
      title: 'Criar novo grupo',
      body: Column(
        children: [
          GrandeCampoImagem(label: 'Imagem do grupo'),
          CampoTexto(
            controller: nomeGrupoController,
            label: 'NOME DO GRUPO',
          ),
          CampoTexto(
            controller: descricaoGrupoController,
            label: 'DESCRIÇÃO',
            extendido: true,
          ),
          SizedBox(height: 20),
          CampoSelecao(
            selected: selectedModoPontuacao,
            opcoes: ['Pontos por Atividade', 'Pontos por Dias Ativos'],
          ),
          SizedBox(height: 20),
          CampoSelecao(
            selected: selectedQtdDias,
            opcoes: ['10 dias', '20 dias', '30 dias', '40 dias', '60 dias'],
          ),
          Spacer(),
          Botao(label: 'Criar novo grupo', onPressed: () {Navigator.pushNamed(context, '/grupo');},),
          Spacer(),
        ],
      ),
    );
  }
}
