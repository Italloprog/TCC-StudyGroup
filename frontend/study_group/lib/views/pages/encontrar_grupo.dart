import 'package:flutter/material.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/campo_texto.dart';
import 'package:study_group/views/widgets/icone_grande_app.dart';
import 'package:study_group/views/widgets/scafolld_base.dart';

class EncontrarGrupoPage extends StatefulWidget {
  const EncontrarGrupoPage({super.key});

  @override
  State<EncontrarGrupoPage> createState() => _EncontrarGrupoPageState();
}

class _EncontrarGrupoPageState extends State<EncontrarGrupoPage> {
  final TextEditingController _codigoGrupoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScafolldBase(
      title: 'Entrar em grupo existente',
      body: Column(
        children: [
          IconeGrandeApp(),
          CampoTexto(controller: _codigoGrupoController, label: 'Digite o código de convite do grupo', hint: 'Código...',),
          Spacer(),
          Botao(label: 'Entrar em grupo existente', onPressed: (){Navigator.pushNamed(context, '/grupo');}),
          Spacer(),
        ],
        ),
    );
  }
}