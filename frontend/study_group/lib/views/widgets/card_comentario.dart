import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/comentario_controller.dart';
import 'package:study_group/controllers/providers/grupo_controller.dart';

class CardComentario extends StatefulWidget {
  const CardComentario({super.key, required this.nomeUsuario, required this.comentario, this.imagemUsuario, required this.idComentario, required this.idPostagem, required this.mostrarLixeira});

  final String nomeUsuario;
  final String comentario;
  final String? imagemUsuario;
  final String idComentario;
  final String idPostagem;
  final bool mostrarLixeira;

  @override
  State<CardComentario> createState() => _CardComentarioState();
}

class _CardComentarioState extends State<CardComentario> {
  @override
  Widget build(BuildContext context) {
    final comentarioController = context.watch<ComentarioController>();
    final grupoController = context.watch<GrupoController>();

    return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                    color: Color.fromARGB(255, 58, 17, 89),
                    borderRadius: BorderRadius.circular(15),
                  ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: (widget.imagemUsuario != null && widget.imagemUsuario!.isNotEmpty) 
                        ? MemoryImage(base64Decode(widget.imagemUsuario!)) 
                        : null,
                    radius: 28,
                    child: (widget.imagemUsuario == null || widget.imagemUsuario!.isEmpty) 
                        ? const Icon(Icons.person) : null,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.nomeUsuario,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 190,
                        child: Text(
                          widget.comentario,
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  if (widget.mostrarLixeira)
                    if (comentarioController.isLoading)
                      const CircularProgressIndicator()
                    else
                  IconButton(
                      onPressed: () async {
        // 1. Pede confirmação
        bool confirmar = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Excluir Comentário?'),
            content: const Text('Esta ação não pode ser desfeita, o comentário será removido permanentemente.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                
                child: const Text('Cancelar',style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Excluir', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ?? false;

        // 2. Chama a exclusão no controller
        if (confirmar && context.mounted) {
          final sucesso = await context.read<ComentarioController>().excluirComentario(
            grupoController.idGrupoAtual!,
            widget.idPostagem,
            widget.idComentario,
          );

          if (sucesso && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Comentário excluído!'), behavior: SnackBarBehavior.floating),
            );
          }else if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Falha ao excluir comentário, tente novamente.'), behavior: SnackBarBehavior.floating),
            );
          }
        }
      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ))
                ],
              ),
            );
  }
}