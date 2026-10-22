import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/grupo_controller.dart';
import 'package:study_group/views/widgets/card_postagem.dart';
import 'package:study_group/views/widgets/scafolld_base.dart';

class GrupoPage extends StatefulWidget {
  const GrupoPage({super.key, required this.idGrupo});

  final String idGrupo;

  @override
  State<GrupoPage> createState() => _GrupoPageState();
}

class _GrupoPageState extends State<GrupoPage> {
  @override
  void initState() {
    super.initState();
    // Assim que abrir a tela, pede para o Controller buscar os dados do grupo e postagens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GrupoController>().buscarDadosGrupo(widget.idGrupo);
      context.read<GrupoController>().setIdGrupoAtual(widget.idGrupo); // Atualiza o ID do grupo atual no controller
    });
  }

  @override
  Widget build(BuildContext context) {
    final grupoController = context.watch<GrupoController>();

    final dadosGrupo = grupoController.dadosGrupo;
    final postagens = grupoController.postagens;

    return ScafolldBase(
      egrupo: true,
      title: dadosGrupo?['nome'] ?? 'Carregando...',
      body: grupoController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : dadosGrupo == null
              ? const Center(child: Text("Erro ao carregar o grupo."))
              : Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: dadosGrupo['fotoGrupo'] != null
                              ? Image.memory(
                                  base64Decode(dadosGrupo['fotoGrupo']),
                                  width: 320,
                                  height: 150,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 320,
                                      height: 150,
                                      color: Colors.grey,
                                      child: Icon(Icons.image_not_supported),
                                    );
                                  },
                                )
                              : Container(
                                  width: 320,
                                  height: 150,
                                  
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 116, 52, 184),
                                    image: DecorationImage(
                                      image: AssetImage('lib/assets/iconeApp2.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  
                                ),
                        ),
                
                        SizedBox(
                          height: 10,
                        ),
                
                        Text(
                          'ultimas postagens',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        
                        // 2. O Construtor Dinâmico de Postagens (Builder)
                        postagens.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Text("Nenhuma postagem neste grupo ainda."),
                                    SizedBox(height: 4),
                                    Text(
                                      'Quem será o primeiro?',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:  Color.fromARGB(255, 116, 52, 184),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                // shrinkWrap e NeverScrollable são OBRIGATÓRIOS quando
                                // o ListView está dentro de um SingleChildScrollView!
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: postagens.length,
                                itemBuilder: (context, index) {
                                  final post = postagens[index];
                
                                  return CardPostagem(
                                    // Substitua as chaves abaixo pelas exatas do seu banco de dados
                                    imagem: post['imagemBase64'] ?? '',
                                    titulo: post['titulo'] ?? 'Sem título',
                                    autor: post['autorNome'] ?? 'Usuário',
                                    data: post['createdAt'] ?? 'Data',
                                    indexPostagem: index,
                                  );
                                },
                              ),
                        //CardPostagem(imagem: 'https://64.media.tumblr.com/cf6f3ccc3072950be60ffac9ca2da15b/53fb534a18ebefad-64/s1280x1920/104a2ebe9c1595425d9d32cc4e4b98f74736cab3.pnj', titulo: 'Estudo de matemática', autor: 'Pessoa 2', data: '12 jan.'),
                
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
              ),
    );
  }
}
