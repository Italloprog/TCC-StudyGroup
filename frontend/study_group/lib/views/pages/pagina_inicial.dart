import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/usuario_controller.dart';
import 'package:study_group/views/widgets/Icone_grande_app.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/card_grupo.dart';
import 'package:study_group/views/widgets/scafolld_base.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<UsuarioController>().carregarPerfil();
    });
  }

  bool _isGrupoFinalizado(Map<String, dynamic> grupo) {
    if (grupo['dataInicio'] == null || grupo['qtdDias'] == null) return false;

    Timestamp dataInicio = grupo['dataInicio'];
    String qtdDias = grupo['qtdDias'];
    int formatadoQtdDias = int.parse(qtdDias.split(' ')[0]);

    DateTime dataInicioDate = dataInicio.toDate();
    DateTime dataAtual = DateTime.now();
    DateTime dataFim = dataInicioDate.add(Duration(days: formatadoQtdDias));

    int diasRestantes = dataFim.difference(dataAtual).inDays;
    return diasRestantes <= 0; // Se for 0 ou menos, está finalizado
  }

  @override
  Widget build(BuildContext context) {
    final usuarioController = context.watch<UsuarioController>();
    final grupos = usuarioController.gruposUsuario;

    // SEPARANDO OS GRUPOS EM DUAS LISTAS
    final gruposAtivos = grupos.where((g) => !_isGrupoFinalizado(g)).toList();
    final gruposFinalizados = grupos.where((g) => _isGrupoFinalizado(g)).toList();

    return ScafolldBase(
      body: usuarioController.isLoading
          ? const Center(child: CircularProgressIndicator()) // Mostra carregamento inicial
          :
        SingleChildScrollView(
        child: Column(
          children: [
            
            IconeGrandeApp(),
        
            SizedBox(
              height: grupos.isNotEmpty? 0 : 10, // Espaço extra se houver grupos
            ),
        
            // TÍTULO DINÂMICO OU MENSAGEM VAZIA
                  SizedBox(
                    width: 340,
                    child: Text(
                      grupos.isEmpty 
                          ? 'Você ainda não participa de nenhum grupo.'
                          : 'Sua lista de Grupos',
                      style: const TextStyle(fontSize: 20), 
                      textAlign: TextAlign.center,
                    ),
                  ),
        
                    gruposAtivos.isNotEmpty? 
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true, // Importante dentro de SingleChildScrollView
                      physics: const NeverScrollableScrollPhysics(), // Evita scroll duplo
                      itemCount: gruposAtivos.length,
                      itemBuilder: (context, index) {
                        final grupo = gruposAtivos[index];

                        return CardGrupo(
                            nomeGrupo: grupo['nome'] ?? 'Grupo sem nome',
                            idGrupo: grupo['idGrupo'],
                            dataInicio: grupo['dataInicio'] as Timestamp? ?? Timestamp.now(),
                            qtdDias: grupo['qtdDias'] ?? '0 dias',
                            imagemCapa: grupo['fotoGrupo'], // Envia a string Base64 pro seu widget
                            finalizado: false, // Indica que este grupo não está finalizado
                            //finalizado: false,
                        );
                      },
                    ): const SizedBox.shrink(), // Se não houver grupos, não mostra nada
                    
                    gruposFinalizados.isNotEmpty? 
                    SizedBox(
                    width: 340,
                    child: Text(
                      'Grupos finalizados',
                      style: const TextStyle(fontSize: 18, color: Color.fromARGB(155, 205, 158, 255)), 
                      textAlign: TextAlign.center,
                    ),
                  ): const SizedBox.shrink(), // Se não houver grupos finalizados, não mostra nada

                    gruposFinalizados.isNotEmpty? 
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true, // Importante dentro de SingleChildScrollView
                      physics: const NeverScrollableScrollPhysics(), // Evita scroll duplo
                      itemCount: gruposFinalizados.length,
                      itemBuilder: (context, index) {
                        final grupo = gruposFinalizados[index];

                        return CardGrupo(
                            nomeGrupo: grupo['nome'] ?? 'Grupo sem nome',
                            idGrupo: grupo['idGrupo'],
                            dataInicio: grupo['dataInicio'] as Timestamp? ?? Timestamp.now(),
                            qtdDias: grupo['qtdDias'] ?? '0 dias',
                            imagemCapa: grupo['fotoGrupo'], // Envia a string Base64 pro seu widget
                            finalizado: true, // Indica que este grupo está finalizado
                            //finalizado: false,
                        );
                      },
                    ): const SizedBox.shrink(), //
            
            SizedBox(
              height: 20, // Espaço extra se houver grupos
            ),
        
            Botao(label: 'Criar novo grupo', onPressed: (){
              Navigator.pushNamed(context, '/novo_grupo');
            }),
        
            const SizedBox(
              height: 20,
            ),
            
            Botao(label: 'Entrar em grupo existente', onPressed: (){
              Navigator.pushNamed(context, '/encontrar_grupo');
            }),

            SafeArea(child: SizedBox(height: 20,))
          ],
        ),
      )
    );
  }
}