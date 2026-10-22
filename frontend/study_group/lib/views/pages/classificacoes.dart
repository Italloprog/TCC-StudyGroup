import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/grupo_controller.dart';
import 'package:study_group/views/widgets/card_podio.dart';
import 'package:study_group/views/widgets/scafolld_arrowback.dart';

class ClassificacoesPage extends StatefulWidget {
  const ClassificacoesPage({super.key});

  @override
  State<ClassificacoesPage> createState() => _ClassificacoesPageState();
}

class _ClassificacoesPageState extends State<ClassificacoesPage> {
  @override
  void initState() {
    super.initState();
    // Assim que abrir a tela, pede ao Controller para baixar o ranking
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GrupoController>().carregarClassificacao();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final grupoController = context.watch<GrupoController>();
    final ranking = grupoController.classificacao;

    return ScafolldArrowback(
      title: 'Classificações',
      egrupo: true,
      body: grupoController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            if (ranking.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                                  children: [
                                    Text("Nenhuma postagem neste grupo ainda."),
                                    SizedBox(height: 4),
                                    Text(
                                      'Quem será o primeiro?',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:  Color.fromARGB(255, 205, 158, 255),
                                      ),
                                    ),
                                  ],
                                ),
                    ),
                    
            ListView.builder(
                    shrinkWrap: true, // Necessário dentro de SingleChildScrollView
                    physics: const NeverScrollableScrollPhysics(), // Evita scroll duplo
                    itemCount: ranking.length,
                    itemBuilder: (context, index) {
                      final usuario = ranking[index];

                      return CardPodio(
                        nome_perfil: usuario['nome'] ?? 'Membro',
                        pontos_perfil: usuario['pontos'] ?? 0,
                        
                        // Passa a foto em Base64 do banco
                        imagem_perfil: usuario['fotoPerfil'] ?? '', 
                        
                        // A colocação é o índice + 1 (0 vira 1º, 1 vira 2º, etc)
                        colocacao: index + 1, 
                      );
                    },
                  ),

            SafeArea(child: Container()), // Garante que o conteúdo não fique atrás da barra de navegação
          ],
        ),
      ),
      );
  }
}