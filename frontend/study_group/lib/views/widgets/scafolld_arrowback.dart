import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/grupo_controller.dart';
import 'package:study_group/controllers/providers/postagem_controller.dart';
import 'package:study_group/controllers/providers/usuario_controller.dart';
import 'package:study_group/views/pages/grupo.dart';

class ScafolldArrowback extends StatefulWidget {
  const ScafolldArrowback({super.key, this.title, required this.body, this.egrupo = false, this.epostagem = false, this.idPostagem,this.idGrupo});
  final String? title;
  final Widget body;
  final bool egrupo;
  final bool epostagem;
  final String? idPostagem;
  final String? idGrupo;

  @override
  State<ScafolldArrowback> createState() => _ScafolldArrowbackState();
}

class _ScafolldArrowbackState extends State<ScafolldArrowback> {

  int _diasRestantes() {
    var dadosGrupo = context.read<GrupoController>().dadosGrupo;
    if (dadosGrupo?['qtdDias'] == null || dadosGrupo?['dataInicio'] == null) {
      return 0;
    }
    int formatadoQtdDias = int.parse(dadosGrupo?['qtdDias'].split(' ')[0]); // Extrai apenas o número de dias da string
    DateTime dataInicioDate = dadosGrupo?['dataInicio']!.toDate();
    DateTime dataAtual = DateTime.now();

    DateTime dataFim = dataInicioDate.add(Duration(days: formatadoQtdDias));

    int diasRestantes = (dataFim.difference(dataAtual).inDays);
    return diasRestantes > 0 ? diasRestantes : 0;
  }

  @override
  Widget build(BuildContext context) {
    final postagemController = context.watch<PostagemController>();
    final grupoController = context.watch<GrupoController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? '', style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 58, 17, 89),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: widget.egrupo || widget.epostagem ? [
          if (widget.egrupo) ...[
            Text('Faltam\n${_diasRestantes()} dias',
          style: TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center,),
            SizedBox(width: 10),
            Icon(Icons.date_range, color: Colors.white),
            SizedBox(width: 15),
          ],
          if (widget.epostagem)
            postagemController.isLoading
                    ? const CircularProgressIndicator()
                    : 
            IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: () async {
                    // 1. Pede confirmação primeiro!
                    bool confirmar = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Apagar Postagem?'),
                            content: const Text(
                                'Essa postagem será excluida permanentemente. Deseja continuar?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Apagar',style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        ) ?? false;

                    // 2. Se o usuário confirmou, chama o Controller
                    if (confirmar && context.mounted) {
                      final sucesso = await context.read<PostagemController>().excluirPostagem(widget.idGrupo!,widget.idPostagem!);

                      if (sucesso && context.mounted) {
                        context.read<GrupoController>().buscarDadosGrupo(grupoController.idGrupoAtual!);
                        context.read<UsuarioController>().carregarPerfil(); // Atualiza o perfil do usuário para refletir os novos pontos

                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Postagem excluida com sucesso.'),behavior: SnackBarBehavior.floating,),);

                        Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context) => GrupoPage(
                                        idGrupo: widget.idGrupo!,
                                      ),
                                    ),
                                  );

                      } else if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Erro ao tentar apagar postagem, tente novamente.'),behavior: SnackBarBehavior.floating,),
                        );
                      }
                    }
                  },
            ),
        ] : null,
        
      ),
      
      body: Center(
        child: widget.body,
      ));
  }
}