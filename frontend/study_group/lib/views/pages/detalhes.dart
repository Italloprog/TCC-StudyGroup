import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/grupo_controller.dart';
import 'package:study_group/controllers/providers/usuario_controller.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/card_membro.dart';
import 'package:study_group/views/widgets/scafolld_arrowback.dart';
import 'package:study_group/views/widgets/texto_com_linha.dart';

class DetalhesPage extends StatefulWidget {
  const DetalhesPage({super.key});

  @override
  State<DetalhesPage> createState() => _DetalhesPageState();
}

class _DetalhesPageState extends State<DetalhesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async { 
      await context.read<UsuarioController>().carregarPerfilPesquisado(context.read<GrupoController>().dadosGrupo?['criadorId']);
      // ignore: use_build_context_synchronously
      await context.read<GrupoController>().carregarMembrosDoGrupo();

    });
  }

  int _diasRestantes(Timestamp dataInicio, String qtdDias) {
    int formatadoQtdDias = int.parse(
        qtdDias.split(' ')[0]); // Extrai apenas o número de dias da string
    DateTime dataInicioDate = dataInicio.toDate();
    DateTime dataAtual = DateTime.now();

    DateTime dataFim = dataInicioDate.add(Duration(days: formatadoQtdDias));

    int diasRestantes = (dataFim.difference(dataAtual).inDays);
    return diasRestantes > 0 ? diasRestantes : 0;
  }

  @override
  Widget build(BuildContext context) {
    final grupoController = context.watch<GrupoController>();
    final usuarioController = context.watch<UsuarioController>();
    final dadosUsuarioPesquisado = usuarioController.dadosUsuarioPesquisado;
    final dadosGrupo = grupoController.dadosGrupo;
    final membrosDetalhes = grupoController.membrosDetalhes;

    return ScafolldArrowback(
        title: 'Detalhes',
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                dadosGrupo?['nome'] ?? 'Carregando...',
                style: TextStyle(
                  fontSize: 24,
                  decoration: TextDecoration.underline,
                  decorationThickness: 0.5,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 1.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
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
                      radius: 35,
                      backgroundImage: (dadosUsuarioPesquisado?['fotoPerfil'] !=
                                  null &&
                              dadosUsuarioPesquisado!['fotoPerfil']!.isNotEmpty)
                          ? MemoryImage(base64Decode(dadosUsuarioPesquisado[
                              'fotoPerfil']!)) // Transforma texto em imagem
                          : null,
                      child: (dadosUsuarioPesquisado?['fotoPerfil'] == null ||
                              dadosUsuarioPesquisado!['fotoPerfil']!.isEmpty)
                          ? const Icon(Icons.person, size: 35)
                          : null,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          dadosUsuarioPesquisado?['nome'] ?? 'Carregando...',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Admin do grupo',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 350,
                child: Text(
                  dadosGrupo?['descricao'] ?? 'Carregando...',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextoComLinha(
                    texto:
                        'Código de convite: ${dadosGrupo?['codigoConvite'] ?? 'Carregando...'}',
                    tamanho: 18,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () async {
                      // Copiar o código de convite para a área de transferência
                      final codigoConvite = dadosGrupo?['codigoConvite'] ?? '';
                      await Clipboard.setData(
                          ClipboardData(text: codigoConvite));
                      if (context.mounted) {
                        // 3. Mostra uma mensagem de sucesso na parte inferior da tela
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Código de convite "$codigoConvite" copiado com sucesso!'),
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior
                                .floating, // Deixa o aviso flutuante e mais bonito
                          ),
                        );
                      }
                    },
                    child: Icon(
                      Icons.share_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextoComLinha(
                texto:
                    'Modo de pontuação: ${dadosGrupo?['modoPontuacao'] ?? 'Carregando...'}',
                tamanho: 18,
              ),
              SizedBox(
                height: 10,
              ),
              TextoComLinha(
                texto:
                    'Data de Criação: ${(DateFormat('dd/MM/yyyy').format((dadosGrupo?['dataInicio'] as Timestamp?)!.toDate()))}',
                tamanho: 18,
              ),
              SizedBox(
                height: 10,
              ),
              TextoComLinha(
                texto:
                    'Dias Restantes: ${_diasRestantes(dadosGrupo?['dataInicio'], dadosGrupo?['qtdDias'])}',
                tamanho: 18,
              ),
              SizedBox(
                height: 10,
              ),
              TextoComLinha(
                texto:
                    'Periodo total: ${dadosGrupo?['qtdDias'] ?? 'Carregando...'}',
                tamanho: 18,
              ),
              SizedBox(
                height: 10,
              ),

              TextoComLinha(
                texto:
                    'Total de postagens: ${grupoController.postagens.length}',
                tamanho: 18,
              ),

              SizedBox(
                height: 10,
              ),

              TextoComLinha(
                texto:
                    'Quantidade de membros: ${dadosGrupo?['membros'].length ?? 'Carregando...'}',
                tamanho: 18,
              ),

              membrosDetalhes.isEmpty 
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : ListView.builder(
                    shrinkWrap: true, // Obrigatório aqui
                    physics: const NeverScrollableScrollPhysics(), 
                    itemCount: membrosDetalhes.length,
                    itemBuilder: (context, index) {
                      final membro = membrosDetalhes[index];
                      return CardMembro(
                        nome_perfil: membro['nome'] ?? 'Membro',
                        imagem_perfil: membro['fotoPerfil'], // Envia a string Base64 pro seu widget
                        idUsuario: membro['uid'],
                      );
                    },
                  ),
              
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Botao(
                  label: '🚫 Deixar grupo',
                  onPressed: () async {
                    // 1. Pede confirmação primeiro!
                    bool confirmar = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Sair do Grupo?'),
                            content: const Text(
                                'Você deixará de participar deste grupo e não verá mais as postagens. Deseja continuar?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                
                                child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Sair',style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        ) ?? false;

                    // 2. Se o usuário confirmou, chama o Controller
                    if (confirmar && context.mounted) {
                      final sucesso = await context.read<GrupoController>().sairDoGrupo();

                      if (sucesso && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Você saiu do grupo.'),behavior: SnackBarBehavior.floating,),);

                        // 3. Ao sair do grupo, limpamos a pilha de navegação da tela do grupo
                        // e jogamos ele de volta para a PaginaInicial.
                        // O UsuarioController na PaginaInicial cuidará de atualizar a lista de grupos lá!
                        Navigator.pushNamedAndRemoveUntil(context, '/pagina_inicial', (route) => false);

                      } else if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Erro ao tentar sair do grupo, tente novamente.'),behavior: SnackBarBehavior.floating,),
                        );
                      }
                    }
                  },
                  padding_v: 15,
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              if(dadosGrupo?['criadorId'] == FirebaseAuth.instance.currentUser?.uid )
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Botao(
                    label: '⚙️ Editar grupo',
                    onPressed: () {
                      Navigator.pushNamed(context, '/editar_grupo');
                    },
                    padding_v: 15,
                  ),
                ],
              ),
              SafeArea(
                child: SizedBox(
                  height: 20,
                ),
              ),
            ],
          ),
        ));
  }
}
