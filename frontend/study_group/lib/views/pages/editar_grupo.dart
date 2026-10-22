import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/grupo_controller.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/campo_selecao.dart';
import 'package:study_group/views/widgets/campo_texto.dart';
import 'package:study_group/views/widgets/grande_campo_imagem.dart';
import 'package:study_group/views/widgets/scafolld_arrowback.dart';

class EditarGrupoPage extends StatefulWidget {
  const EditarGrupoPage({super.key});

  @override
  State<EditarGrupoPage> createState() => _EditarGrupoPageState();
}

class _EditarGrupoPageState extends State<EditarGrupoPage> {

  File? _imagem;
  final TextEditingController nomeGrupoController = TextEditingController();
  final TextEditingController descricaoGrupoController = TextEditingController();
  
  String selectedModoPontuacao = "Modo de pontuação";
  String selectedQtdDias = "Quantidade de dias";
  

  @override
  void initState() {
    super.initState();
    // 1. Preenchemos os dados apenas UMA VEZ quando a tela abre
    // Usamos read() no initState, nunca watch()
    final dadosGrupo = context.read<GrupoController>().dadosGrupo;
    
    if (dadosGrupo != null) {
      nomeGrupoController.text = dadosGrupo['nome'] ?? '';
      descricaoGrupoController.text = dadosGrupo['descricao'] ?? '';
      selectedModoPontuacao = dadosGrupo['modoPontuacao'] ?? 'Modo de pontuação';
      selectedQtdDias = dadosGrupo['qtdDias'] ?? 'Quantidade de dias';
    }
  }

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
  void dispose() {
    // É boa prática liberar os controllers da memória ao sair da tela
    nomeGrupoController.dispose();
    descricaoGrupoController.dispose();
    super.dispose();
  }

  int _diasPassados(Timestamp dataInicio) {
    DateTime dataInicioDate = dataInicio.toDate();
    DateTime dataAtual = DateTime.now();

    int diasPassados = (dataAtual.difference(dataInicioDate).inDays);
    return diasPassados > 0 ? diasPassados : 0;
  }
  
  @override
  Widget build(BuildContext context) {
    final grupoController = context.watch<GrupoController>();
    final dadosGrupo = grupoController.dadosGrupo;

    return ScafolldArrowback(
        title: 'Editar Grupo',
        body: SingleChildScrollView(
          child: Column(
          children: [
            GrandeCampoImagem(label: 'Imagem do grupo', onpressed: _pegarImagemDaGaleria, imagem: _imagem, imagemBase64: dadosGrupo?['fotoGrupo'],),

            CampoTexto(
              controller: nomeGrupoController,
              label: 'NOME DO GRUPO',
              hint: 'Digite o nome do grupo...',
            ),
            CampoTexto(
              controller: descricaoGrupoController,
              label: 'DESCRIÇÃO',
              hint: 'Descreva o grupo...',
              extendido: true,
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
              opcoes: ['${_diasPassados(dadosGrupo?['dataInicio']) + 5} dias', '${_diasPassados(dadosGrupo?['dataInicio']) + 10} dias', '${_diasPassados(dadosGrupo?['dataInicio']) + 20} dias', '${_diasPassados(dadosGrupo?['dataInicio']) + 30} dias', '${_diasPassados(dadosGrupo?['dataInicio']) + 40} dias'],
              onChanged: (value) {
                setState(() {
                  selectedQtdDias = value;
                });
              },
            ),

            SizedBox(height: 20),

            grupoController.isLoading 
              ? const CircularProgressIndicator()
              : Botao(
                  label: 'Editar grupo', 
                  onPressed: () async {
                    try {
                      final sucesso = await context.read<GrupoController>().editarGrupo(
                        groupId: grupoController.idGrupoAtual!, 
                        nome: nomeGrupoController.text,
                        descricao: descricaoGrupoController.text,
                        modoPontuacao: selectedModoPontuacao,
                        qtdDias: selectedQtdDias,
                        novaImagem: _imagem, // Só enviará ao banco se não for nulo
                      );

                      if (sucesso && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Grupo atualizado com sucesso!'), behavior: SnackBarBehavior.floating),
                        );
                        Navigator.pop(context); // Volta para a tela anterior
                      }
                    } catch (e) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString().replaceAll("Exception: ", "")), behavior: SnackBarBehavior.floating),
                      );
                    }
                  },
                ),

            SafeArea(child: Container()), // Garante que o conteúdo não fique atrás da barra de navegação
          ],
        ),
        ),
      ) ;
      
  }
}