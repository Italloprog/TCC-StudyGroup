import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_group/views/pages/grupo.dart';
import 'package:study_group/views/pages/resultado_grupo.dart';

class CardGrupo extends StatelessWidget {
  const CardGrupo({super.key, this.imagemCapa, required this.nomeGrupo, required this.idGrupo, required this.dataInicio, required this.qtdDias, required this.finalizado});

  final String? imagemCapa;
  final String nomeGrupo;
  final String idGrupo;
  final Timestamp dataInicio;
  final String qtdDias;
  final bool finalizado;

  int _diasRestantes() {
    int formatadoQtdDias = int.parse(qtdDias.split(' ')[0]); // Extrai apenas o número de dias da string
    DateTime dataInicioDate = dataInicio.toDate();
    DateTime dataAtual = DateTime.now();

    DateTime dataFim = dataInicioDate.add(Duration(days: formatadoQtdDias));

    int diasRestantes = (dataFim.difference(dataAtual).inDays);
    return diasRestantes > 0 ? diasRestantes : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: 340,
                height: 120,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 116, 52, 184),
                    borderRadius: BorderRadius.circular(20),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: (imagemCapa != null && imagemCapa!.isNotEmpty) ? MemoryImage(base64Decode(imagemCapa!)) : AssetImage('lib/assets/iconeApp2.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        // ignore: deprecated_member_use
                        Colors.black.withOpacity(0.2),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  highlightColor: const Color.fromARGB(255, 116, 52, 184),
                  focusColor: const Color.fromARGB(255, 116, 52, 184),
                  hoverColor: const Color.fromARGB(255, 116, 52, 184),
                  overlayColor: WidgetStateProperty.all(const Color.fromARGB(255, 116, 52, 184)),
                  
                  onTap: () {

                    if (!finalizado) {
                            Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context) => GrupoPage(
                                        idGrupo: idGrupo,
                                      ),
                                    ),
                                  );
                    } else {

                      Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultadoGrupoPage(
                                        idGrupo: idGrupo,
                                      ),
                                    ),
                                  );
                    }
                          },
      
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
      
                    children: [
                        Text(nomeGrupo, style: TextStyle(fontSize: 24, color: Colors.white),),
                        Text(finalizado 
                            ? (DateFormat('dd/MM/yyyy').format((dataInicio as Timestamp?)!.toDate()))
                            : '${_diasRestantes()} dias restantes', 
                            style: TextStyle(fontSize: 16, color: Colors.white),),
                    ],
                  ),
                )
          ),
    );
  }
}