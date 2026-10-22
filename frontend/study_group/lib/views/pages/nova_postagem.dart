import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/grupo_controller.dart';
import 'package:study_group/controllers/providers/postagem_controller.dart';
import 'package:study_group/controllers/providers/usuario_controller.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/campo_selecao.dart';
import 'package:study_group/views/widgets/campo_tempo.dart';
import 'package:study_group/views/widgets/campo_texto.dart';
import 'package:study_group/views/widgets/grande_campo_imagem.dart';
import 'package:study_group/views/widgets/scafolld_arrowback.dart';

class NovaPostagemPage extends StatefulWidget {
  const NovaPostagemPage({super.key});

  @override
  State<NovaPostagemPage> createState() => _NovaPostagemPageState();
}

class _NovaPostagemPageState extends State<NovaPostagemPage> {
  File? _imagem;
  final TextEditingController tituloPostagemController = TextEditingController();
  final TextEditingController descricaoPostagemController = TextEditingController();
  var selectedTempoDeEstudo = "Tempo de estudo";
  var selectedAreaDeEstudo = "Área de estudo";

  Future<void> _pegarImagemDaGaleria() async {
    // A mágica da compressão acontece aqui
    final XFile? imagemSelecionada = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70, // Reduz a qualidade da imagem para 70%
      maxWidth: 400,    // Reduz a largura máxima
      maxHeight: 400,   // Reduz a altura máxima
    );

    if (imagemSelecionada != null) {
      setState(() {
        _imagem = File(imagemSelecionada.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final postagemController = context.watch<PostagemController>();

    final grupoController = context.watch<GrupoController>();
    
    final dadosUsuario = context.watch<UsuarioController>().dadosUsuario;
    final nomeAutor = dadosUsuario?['nome'] ?? 'Autor Desconhecido';
    final fotoAutor = dadosUsuario?['fotoPerfil'] ?? '';

    return ScafolldArrowback(
        title: 'Nova Postagem',
        body: SingleChildScrollView(
          child: Column(
            children: [
              GrandeCampoImagem(label: 'Imagem da Postagem', onpressed: _pegarImagemDaGaleria, imagem: _imagem, quadrado: true),
              CampoTexto(controller: tituloPostagemController, label: 'TÍTULO', hint: 'Digite o título da postagem...',),
              CampoTexto(controller: descricaoPostagemController, label: 'DESCRIÇÃO', hint: 'Digite a descrição da postagem...', extendido: true,),
              SizedBox(height: 20),
              
              CampoTempo(
                selected: selectedTempoDeEstudo, // Inicialize com "0 minutos" ou outro valor padrão
                onChanged: (value) {
                  setState(() {
                    selectedTempoDeEstudo = value;
                  });
                },
              ),

              SizedBox(height: 20),
              CampoSelecao(selected: selectedAreaDeEstudo,
               opcoes: ['Exatas', 'Humanas', 'Linguagens', 'Saúde', 'Sociais'],
                onChanged: (value) {
                  setState(() {
                    selectedAreaDeEstudo = value;
                  });
                },
              ),
              SizedBox(height: 20),
              
              postagemController.isLoading
                  ? const CircularProgressIndicator()
                  : Botao(
                      label: 'Adicionar', 
                      onPressed: () async {

                        if(_imagem == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Por favor, selecione uma imagem que comprove seu estudo.'),behavior: SnackBarBehavior.floating,),
                          );
                          return;
                        }

                        try {
                          final sucesso = await context.read<PostagemController>().criarPostagem(
                            groupId: grupoController.idGrupoAtual!,
                            titulo: tituloPostagemController.text,
                            descricao: descricaoPostagemController.text,
                            tempoEstudo: selectedTempoDeEstudo,
                            areaEstudo: selectedAreaDeEstudo,
                            imagem: _imagem!,
                            autorNome: nomeAutor, // Enviando o nome do autor!
                            autorFotoBase64: fotoAutor,
                          );

                          if (sucesso && context.mounted) {
                            context.read<GrupoController>().buscarDadosGrupo(grupoController.idGrupoAtual!);
                            context.read<UsuarioController>().carregarPerfil(); // Atualiza o perfil do usuário para refletir os novos pontos

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Postagem adicionada com sucesso!'), behavior: SnackBarBehavior.floating,),
                            );
                            Navigator.pop(context); // Volta para a tela do grupo
                          }
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Erro ao adicionar postagem, verifique se todos os campos estão preenchidos.'), behavior: SnackBarBehavior.floating,),
                          );
                        }
                      },
                    ),

              SafeArea(child: SizedBox(height: 10)), // Garante que o conteúdo não fique atrás da barra de navegação
            ],
          ),
        )
    );
  }
}