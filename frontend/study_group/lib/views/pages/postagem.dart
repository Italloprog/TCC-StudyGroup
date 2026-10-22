import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/comentario_controller.dart';
import 'package:study_group/controllers/providers/grupo_controller.dart';
import 'package:study_group/controllers/providers/usuario_controller.dart';
import 'package:study_group/views/widgets/card_comentario.dart';
import 'package:study_group/views/widgets/scafolld_arrowback.dart';
import 'package:study_group/views/widgets/texto_com_linha.dart';

class PostagemPage extends StatefulWidget {
  const PostagemPage({super.key, required this.indexPostagem});

  final int indexPostagem;

  @override
  State<PostagemPage> createState() => _PostagemPageState();
}

class _PostagemPageState extends State<PostagemPage> {
  final TextEditingController _comentarioController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Assim que a tela abre, busca os comentários da postagem específica
      final grupoController = context.read<GrupoController>();
      final postagem = grupoController.postagens[widget.indexPostagem];
      
      context.read<ComentarioController>().carregarComentarios(
        grupoController.idGrupoAtual!, 
        postagem['idPostagem']
      );
    });
  }

  @override
  void dispose() {
    _comentarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final grupoController = context.watch<GrupoController>();
    final usuarioController = context.watch<UsuarioController>();
    final comentarioController = context.watch<ComentarioController>();

    final postagens = grupoController.postagens;
    final postagem = postagens[widget.indexPostagem];

    final String idUsuarioLogado = FirebaseAuth.instance.currentUser?.uid ?? '';
    final String idDonoDoGrupo = grupoController.dadosGrupo?['criadorId'] ?? '';

    final nomeUsuario = usuarioController.dadosUsuario?['nome'] ?? 'Usuario Logado';
    final fotoBase64Usuario = usuarioController.dadosUsuario?['fotoPerfil'];

    return ScafolldArrowback(
      epostagem: (postagem['autorId'] == idUsuarioLogado) || (idDonoDoGrupo == idUsuarioLogado),
      title: 'Postagem',
      idPostagem: postagem['idPostagem'],
      idGrupo: grupoController.idGrupoAtual,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.memory(
                base64Decode(postagem['imagemBase64']),
                width: 320,
                height: 320,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 116, 52, 184),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 19.5,
                children: [
                  CircleAvatar(
                    backgroundImage: MemoryImage(base64Decode(postagem['autorFotoBase64'])),
                    radius: 28,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        postagem['autorNome'],
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        DateFormat('EEEE, d MMM','pt_BR').format(postagem['createdAt'].toDate()).toLowerCase(),
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TextoComLinha(texto: postagem['titulo']),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                postagem['descricao'],
                style: TextStyle(
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  //margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 116, 52, 184),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer,
                        color: Colors.white,
                      ),
                      Text('${(postagem['tempoEstudo'] as String).split(' ')[0]} ${(postagem['tempoEstudo'] as String).split(' ')[1].substring(0,3)}'),
                    ],
                  ),
                ),
                Container(
                  //margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 116, 52, 184),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.school,
                        color: Colors.white,
                      ),
                      Text(postagem['areaEstudo']),
                    ],
                  ),
                ),
                Container(
                  //margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 116, 52, 184),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      Text('${postagem['qtdPontos']} pontos'),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10),

            comentarioController.isLoading
              ? const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                )
              : comentarioController.comentarios.isEmpty
                  ? Column(
                      children: [
                        Text("Nenhum comentário adicionado."),
                        Text(
                          'Seja o primeiro a comentar!',
                          style: TextStyle(
                            fontSize: 12,
                            color:  Color.fromARGB(255, 205, 158, 255),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: comentarioController.comentarios.length,
                      
                      itemBuilder: (context, index) {
                        final comentario = comentarioController.comentarios[index];
                        return CardComentario(
                          nomeUsuario: comentario['autorNome'] ?? 'Usuário', 
                          comentario: comentario['texto'] ?? '', 
                          imagemUsuario: comentario['autorFotoBase64'], // Passe o base64 para o seu widget
                          idComentario: comentario['idComentario'],
                          idPostagem: postagem['idPostagem'],
                          mostrarLixeira: (comentario['autorId'] == idUsuarioLogado) || (idDonoDoGrupo == idUsuarioLogado),
                        );
                      },
                    ),

            SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 5,
                  children: [
                    CircleAvatar(
                      backgroundImage: (fotoBase64Usuario != null && fotoBase64Usuario.isNotEmpty) 
                          ? MemoryImage(base64Decode(fotoBase64Usuario)) 
                          : null,
                      radius: 28,
                      child: (fotoBase64Usuario == null || fotoBase64Usuario.isEmpty) 
                          ? const Icon(Icons.person) : null,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _comentarioController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 116, 52, 184),
                          hintStyle:
                              TextStyle(color: Color.fromARGB(200, 0, 0, 0)),
                          prefixIconColor: Color.fromARGB(255, 0, 0, 0),
                          hintText: 'Comentário...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          if (_comentarioController.text.trim().isNotEmpty) {
                            // Envia para o controller
                            bool sucesso = await context.read<ComentarioController>().adicionarComentario(
                              idGrupo: grupoController.idGrupoAtual!,
                              idPostagem: postagem['idPostagem'],
                              texto: _comentarioController.text,
                              autorId: idUsuarioLogado,
                              autorNome: nomeUsuario,
                              autorFotoBase64: fotoBase64Usuario,
                            );
              
                            if (sucesso) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Comentário adicionado com sucesso!'), behavior: SnackBarBehavior.floating),
                              );
                              // Limpa o campo se deu certo! A lista já vai recarregar sozinha.
                              _comentarioController.clear();
                              // Opcional: esconder o teclado
                              // ignore: use_build_context_synchronously
                              FocusScope.of(context).unfocus(); 
                            }else{
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Erro ao adicionar comentário, tente novamente.'), behavior: SnackBarBehavior.floating),
                              );
                            }
              
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Escreva um comentário!'), behavior: SnackBarBehavior.floating),
                            );
                          }
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 58, 17, 89),
                        ),
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
