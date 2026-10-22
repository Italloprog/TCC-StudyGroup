import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/grupo_controller.dart';
import 'package:study_group/controllers/providers/usuario_controller.dart';
import 'package:study_group/views/widgets/drawer_base.dart';

class ScafolldBase extends StatefulWidget {
  const ScafolldBase(
      {super.key, this.title, required this.body, this.egrupo = false});

  final String? title;
  final Widget body;
  final bool egrupo;
  
  @override
  State<ScafolldBase> createState() => _ScafolldBaseState();
}

class _ScafolldBaseState extends State<ScafolldBase> {

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
    final usuarioController = context.watch<UsuarioController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? 'StudyGroup',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 58, 17, 89),
        leading: Builder(
            builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: CircleAvatar(
                          backgroundImage: usuarioController.dadosUsuario?['fotoPerfil'] != null
                            ? MemoryImage(base64Decode(usuarioController.dadosUsuario?['fotoPerfil']))
                            : null, // Decodifica o texto para Imagem!fit: BoxFit.cover,
                          child: (usuarioController.dadosUsuario?['fotoPerfil'] == null || usuarioController.dadosUsuario?['fotoPerfil']!.isEmpty)
                            ? const Icon(Icons.person, size: 30)
                            : null,
                    ),
                )),
        actions: widget.egrupo ? [
          Text('Faltam\n${_diasRestantes()} dias',
              style: TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center,),
          SizedBox(width: 10),
          Icon(Icons.date_range, color: Colors.white),
          SizedBox(width: 15),
        ] : null,
      ),
      drawer: DrawerBase(),
      body: Center(
        
        child: widget.body,
      ),
      floatingActionButton: widget.egrupo
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/nova_postagem');
              },
              backgroundColor: const Color.fromARGB(255, 116, 52, 184),
              shape: CircleBorder(),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
      bottomNavigationBar: widget.egrupo
          ? BottomAppBar(
            
              color: const Color.fromARGB(255, 58, 17, 89), // Fundo roxo escuro
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                InkWell(
                  
                    borderRadius: BorderRadius.circular(10),

                    onTap: () {Navigator.pushNamed(context, '/detalhes');},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.manage_accounts,
                            color: Colors.white, size: 26),
                        Text(
                          "Detalhes",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
              
                  InkWell(
                   borderRadius: BorderRadius.circular(10),
                    onTap: () {Navigator.pushNamed(context, '/classificacoes');},
                    child: Column(
                      
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.emoji_events, color: Colors.white, size: 26),
                        Text(
                          "Classificações",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
