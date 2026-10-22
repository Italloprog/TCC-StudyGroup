import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/grupo_controller.dart';

class CardMembro extends StatefulWidget {
  const CardMembro({super.key, required this.nome_perfil, this.imagem_perfil, required this.idUsuario});

  final String nome_perfil;
  final String? imagem_perfil;
  final String idUsuario;

  @override
  State<CardMembro> createState() => _CardMembroState();
}

class _CardMembroState extends State<CardMembro> {
  @override
  Widget build(BuildContext context) {
    return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 116, 52, 184),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: (widget.imagem_perfil != null && widget.imagem_perfil!.isNotEmpty)
                      ? MemoryImage(base64Decode(widget.imagem_perfil!)) // Transforma texto em imagem
                      : null,
            
                    child: (widget.imagem_perfil == null || widget.imagem_perfil!.isEmpty)
                      ? const Icon(Icons.person, size: 25)
                      : null,
                    ),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.nome_perfil, style: TextStyle(fontSize: 16),),

                      Text(widget.idUsuario == context.watch<GrupoController>().dadosGrupo?['criadorId'] ? 'Admin do Grupo' : 'Membro do Grupo',
                       style: TextStyle(fontSize: 12, color: Colors.grey),), 
                    ],
                  ),
                  if(FirebaseAuth.instance.currentUser?.uid == context.watch<GrupoController>().dadosGrupo?['criadorId'] && widget.idUsuario != FirebaseAuth.instance.currentUser?.uid) // Só mostra o botão se o usuário logado for o criador do grupo e não for ele mesmo
                   IconButton(
                    onPressed: () async {
                    // 1. Pede confirmação primeiro!
                    bool confirmar = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Remover Membro do Grupo?'),
                            content: const Text(
                                'Você removerá este membro do grupo e ele não verá mais as postagens. Deseja continuar?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                                ),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Remover',style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        ) ?? false;

                    // 2. Se o usuário confirmou, chama o Controller
                    if (confirmar && context.mounted) {
                      final sucesso = await context.read<GrupoController>().retirarDoGrupo(widget.idUsuario);

                      if (sucesso && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Membro removido do grupo.'),behavior: SnackBarBehavior.floating,),);

                      } else if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Erro ao tentar remover membro do grupo, tente novamente.'),behavior: SnackBarBehavior.floating,),
                        );
                      }
                    }
                  },
                    icon: Icon(Icons.delete), color: Colors.white,),
                  
                ],
              ),
            );
  }
}