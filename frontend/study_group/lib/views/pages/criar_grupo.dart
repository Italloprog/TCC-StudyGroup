import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/grupo_controller.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/campo_selecao.dart';
import 'package:study_group/views/widgets/campo_texto.dart';
import 'package:study_group/views/widgets/grande_campo_imagem.dart';
import 'package:study_group/views/widgets/scafolld_base.dart';

class CriarGrupoPage extends StatefulWidget {
  const CriarGrupoPage({super.key});

  @override
  State<CriarGrupoPage> createState() => _CriarGrupoPageState();
}

class _CriarGrupoPageState extends State<CriarGrupoPage> {
  File? _imagem;
  String selectedModoPontuacao = "Modo de pontuação";
  String selectedQtdDias = "Quantidade de dias";
  final TextEditingController nomeGrupoController = TextEditingController();
  final TextEditingController descricaoGrupoController = TextEditingController();

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
    final grupoController = context.watch<GrupoController>();
    
    return ScafolldBase(
      title: 'Criar novo grupo',
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GrandeCampoImagem(label: 'Imagem do grupo', onpressed: _pegarImagemDaGaleria, imagem: _imagem),

            CampoTexto(
              controller: nomeGrupoController,
              label: 'NOME DO GRUPO',
              hint: 'Digite o nome do grupo...',  
            ),

            CampoTexto(
              controller: descricaoGrupoController,
              label: 'DESCRIÇÃO',
              extendido: true,
              hint: 'Descreva o grupo...',
            ),

            SizedBox(height: 20),

            CampoSelecao(
              selected: selectedModoPontuacao,
              opcoes: ['Pontos por Atividade', 'Pontos por Dias Ativos'],
              onChanged: (value) {
                setState(() {
                  selectedModoPontuacao = value;
                });
              },
            ),

            SizedBox(height: 20),
            
            CampoSelecao(
              selected: selectedQtdDias,
              opcoes: ['10 dias', '20 dias', '30 dias', '40 dias', '60 dias'],
              onChanged: (value) {
                setState(() {
                  selectedQtdDias = value;
                });
              },
            ),

            SizedBox(height: 20),

            grupoController.isLoading ? const CircularProgressIndicator()
            : Botao(label: 'Criar novo grupo',
              onPressed: () async {
                try {
                        final sucesso = await context.read<GrupoController>().criarGrupo(
                          nome: nomeGrupoController.text,
                          descricao: descricaoGrupoController.text,
                          modoPontuacao: selectedModoPontuacao,
                          qtdDias: selectedQtdDias,
                          imagem: _imagem,
                        );

                        if (sucesso && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Grupo criado com sucesso!')),
                          );
                          // Navega para a tela do grupo e remove a tela de criação do histórico
                          Navigator.pushReplacementNamed(context, '/grupo');
                        }else if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Erro ao criar grupo, tente novamente.')),
                          );
                        }
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro ao criar grupo, tente novamente. Detalhes: $e')),
                        );
                      }
             },
             ),
          
            SafeArea(child: Container()), // Garante que o conteúdo não fique atrás da barra de navegação
          ],
        ),
      ),
    );
  }
}
