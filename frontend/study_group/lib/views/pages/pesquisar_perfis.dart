import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/usuario_controller.dart';
import 'package:study_group/views/widgets/card_perfil.dart';
import 'package:study_group/views/widgets/scafolld_base.dart';

class PesquisarPerfisPage extends StatefulWidget {
  const PesquisarPerfisPage({super.key});

  @override
  State<PesquisarPerfisPage> createState() => _PesquisarPerfisPageState();
}

class _PesquisarPerfisPageState extends State<PesquisarPerfisPage> {
  final TextEditingController _perfisController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final usuarioController = context.watch<UsuarioController>();

    return ScafolldBase(
      title: 'Pesquisar perfis',
      body: SafeArea(
        child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
                child: TextFormField(
                  controller: _perfisController,
                  onChanged: (valor) {
                  // Só pesquisa se tiver pelo menos 2 letras (economiza leituras no banco)
                  if (valor.length >= 2 || valor.isEmpty) {
                    context.read<UsuarioController>().pesquisar(valor);
                  }
                },
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 116, 52, 184),
                    hintStyle: TextStyle(color: Color.fromARGB(200, 0, 0, 0)),
                    prefixIconColor: Color.fromARGB(255, 0, 0, 0),
                    hintText: 'Digite o nome...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
              ),
  
              Expanded(
              child: usuarioController.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : usuarioController.resultados.isEmpty
                      ? const Center(child: Text("Nenhum usuário encontrado."))
                      : ListView.builder(
                          itemCount: usuarioController.resultados.length,
                          itemBuilder: (context, index) {
                            final usuario = usuarioController.resultados[index];

                            return CardPerfil(
                                nome_perfil: usuario['nome'] ?? 'Sem nome',
                                // Se não tiver sistema de pontos ainda, passa 0
                                pontos_perfil: usuario['pontos'] ?? 0, 
                                // Passa a string em base64 do banco
                                imagem_perfil: usuario['fotoPerfil'] ?? '',
                                // Se não tiver foto, passa string vazia
                                indexPesquisado: index, 
                              );
                          },
                        ),
            ),
            ],
          ),
      ),
      
    );
  }
}