import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/grupo_controller.dart';
import 'package:study_group/views/pages/grupo.dart';
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
    // Escuta o GrupoController
    final grupoController = context.watch<GrupoController>();
    return ScafolldBase(
      title: 'Entrar em grupo existente',
      body: Column(
        children: [
          IconeGrandeApp(),

          CampoTexto(controller: _codigoGrupoController, label: 'Digite o código de convite do grupo', hint: 'Código...',),

          Spacer(),

          grupoController.isLoading
            ? const CircularProgressIndicator()
            : Botao(
                label: 'Entrar em grupo existente', 
                onPressed: () async {
                  try {
                    
                    String? groupId = await context.read<GrupoController>().entrarNoGrupo(
                      _codigoGrupoController.text,
                    );

                    if (groupId != null && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Você entrou no grupo com sucesso!'), behavior: SnackBarBehavior.floating),
                      );
                      
                      // Limpa o campo para a próxima vez
                      _codigoGrupoController.clear();
              
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GrupoPage(idGrupo: groupId),
                        ),
                      );
                      
                    }
                  } catch (e) {
                    // Mostra o erro (ex: "Código inválido") num Snackbar
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString().replaceAll("Exception: ", "")),behavior: SnackBarBehavior.floating),
                    );
                  }
                },
              ),

          Spacer(),
        ],
        ),
    );
  }
}