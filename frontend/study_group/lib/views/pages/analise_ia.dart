import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/ai_controller.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/card_info.dart';
import 'package:study_group/views/widgets/icone_grande_app.dart';
import 'package:study_group/views/widgets/scafolld_arrowback.dart';

class AnaliseIAPage extends StatefulWidget {
  const AnaliseIAPage({super.key});

  @override
  State<AnaliseIAPage> createState() => _AnaliseIAPageState();
}

class _AnaliseIAPageState extends State<AnaliseIAPage> {
  @override
  void initState() {
    super.initState();
    // Pede a análise assim que a tela abre
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AIController>().gerarAnalise();
    });
  }

  @override
  Widget build(BuildContext context) {
    final aiController = context.watch<AIController>();
    final analise = aiController.analiseGerada;

    return ScafolldArrowback(
      title: 'Análise de Estudos',
      body: aiController.isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color:  Color.fromARGB(255, 116, 52, 184)),
                  SizedBox(height: 20),
                  Text(
                    "A IA está analisando seus estudos...\nIsso pode levar alguns segundos 🧠",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : analise == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Não foi possível gerar a análise agora. Publique seus ultimos estudos e tente novamente.", textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
                      const SizedBox(height: 20),
                      Botao(
                        label: 'Tentar novamente',
                        onPressed: () => context.read<AIController>().gerarAnalise(),
                      )
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [

                      IconeGrandeApp(),

                      Text(
                        "Analise de Estudos gerada com IA utilizando as suas últimas postagens. Cada analise é unica. Dica: Tire um print da tela caso queira guardar a análise.",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12, color: Color.fromARGB(125, 255, 255, 255), height: 1),
                      ),

                      const SizedBox(height: 10),

                      CardInfo(
                        titulo: "Resumo Geral",
                        conteudo: analise['resumo'] ?? '',
                        icone: Icons.insights,
                        cor: Colors.blueAccent,
                      ),
                      CardInfo(
                        titulo: "Pontos Fortes",
                        conteudo: analise['pontosFortes'] ?? '',
                        icone: Icons.thumb_up,
                        cor: Colors.amber,
                      ),
                      CardInfo(
                        titulo: "O que melhorar",
                        conteudo: analise['pontoDeMelhoria'] ?? '',
                        icone: Icons.trending_up,
                        cor: Colors.orangeAccent,
                      ),
                      CardInfo(
                        titulo: "Dica da IA",
                        conteudo: analise['sugestao'] ?? '',
                        icone: Icons.lightbulb,
                        cor: Colors.greenAccent,
                      ),
                      const SafeArea(child: SizedBox(),),
                    ],
                  ),
                ),
    );
  }
}