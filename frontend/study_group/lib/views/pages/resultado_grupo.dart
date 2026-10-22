import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/grupo_controller.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/card_podio.dart';
import 'package:study_group/views/widgets/scafolld_base.dart';
import 'package:study_group/views/widgets/texto_com_linha.dart';

class ResultadoGrupoPage extends StatefulWidget {
  const ResultadoGrupoPage({super.key, required this.idGrupo});

  final String idGrupo;
  @override
  State<ResultadoGrupoPage> createState() => _ResultadoGrupoPageState();
}

class _ResultadoGrupoPageState extends State<ResultadoGrupoPage> {

  @override
  void initState() {
    super.initState();
    // Assim que abrir a tela, pede para o Controller buscar os dados do grupo e postagens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GrupoController>().buscarDadosGrupo(widget.idGrupo);
      context.read<GrupoController>().setIdGrupoAtual(widget.idGrupo); // Atualiza o ID do grupo atual no controller
      context.read<GrupoController>().carregarClassificacao();
    });
  }

  @override
  Widget build(BuildContext context) {

    final grupoController = context.watch<GrupoController>();
    final dadosGrupo = grupoController.dadosGrupo;
    final ranking = grupoController.classificacao;

    return ScafolldBase(
      title: 'Resultado do Grupo',

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

                        SizedBox(
                          width: 250,
                          child: Text(
                            'Este grupo finalizou seu periodo total de dias de estudo!',
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),

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
                
                        SizedBox(height: 10),
                
                        Text(
                          dadosGrupo['nome'] ?? 'Nome do Grupo',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                
                        SizedBox(height: 10),
                
                        SizedBox(
                          width: 350,
                          child: Text(
                            dadosGrupo['descricao'] ?? 'Descrição do Grupo',
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                
                        SizedBox(height: 20),
                
              TextoComLinha(
                texto:
                    'Modo de pontuação:',
                tamanho: 18,
              ),

              Text(
                '${dadosGrupo['modoPontuacao'] ?? 'Carregando...'}',
                style: const TextStyle(fontSize: 18),
              ),

              SizedBox(
                height: 8,
              ),
              TextoComLinha(
                texto:
                    'Data de Criação:',
                tamanho: 18,
              ),

              Text(
                (DateFormat('dd/MM/yyyy').format((dadosGrupo['dataInicio'] as Timestamp?)!.toDate())),
                style: const TextStyle(fontSize: 18),
              ),
              
              SizedBox(
                height: 8,
              ),
              TextoComLinha(
                texto:
                    'Periodo total: ${dadosGrupo['qtdDias'] ?? 'Carregando...'}',
                tamanho: 18,
              ),
              SizedBox(
                height: 8,
              ),

              TextoComLinha(
                texto:
                    'Total de postagens: ${grupoController.postagens.length}',
                tamanho: 18,
              ),

              SizedBox(
                height: 8,
              ),

              TextoComLinha(
                texto:
                    'Quantidade de membros: ${dadosGrupo['membros'].length ?? 'Carregando...'}',
                tamanho: 18,
              ),

              SizedBox(height: 10,),

              Text(
                'Parabens ao vencedor!',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 205, 158, 255)),
              ),


              if (ranking.isNotEmpty)
                CardPodio(
                  nome_perfil: ranking[0]['nome'] ?? 'Membro',
                  pontos_perfil: ranking[0]['pontos'] ?? 0,
                  imagem_perfil: ranking[0]['fotoPerfil'] ?? '',
                  colocacao: 1,
                  tamanho: 40,
                )
              else
                const Text("Nenhum membro pontuou neste grupo."),

              if (ranking.length > 1)
                Column(
                  children: [
                    Text(
                      'Outros Participantes',
                      style: const TextStyle(fontSize: 14, color: Color.fromARGB(155, 205, 158, 255)),
                    ),
                    for (int i = 1; i < ranking.length; i++)
                      CardPodio(
                        nome_perfil: ranking[i]['nome'] ?? 'Membro',
                        pontos_perfil: ranking[i]['pontos'] ?? 0,
                        imagem_perfil: ranking[i]['fotoPerfil'] ?? '',
                        colocacao: i + 1,
                        tamanho: 25,
                      ),
                  ],
                )
              else
                const SizedBox.shrink(),

              SizedBox(height: 20,),

              Botao(label:  FirebaseAuth.instance.currentUser?.uid == ranking[0]['idUsuario'] ?'🎉 Incrivel!': '💪🏽 Por pouco!', 
              padding_h: 45, padding_v: 15,
              onPressed: (){
                Navigator.pop(context);
              }),

              SafeArea(child: Container()),
                
                      ],
                    ),
                  ),
              ),
    );
  }
}