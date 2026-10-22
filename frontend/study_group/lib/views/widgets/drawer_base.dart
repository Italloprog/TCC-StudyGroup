import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/usuario_controller.dart';
import 'package:study_group/views/widgets/texto_com_linha.dart';

class DrawerBase extends StatefulWidget {
  const DrawerBase({super.key});

  @override
  State<DrawerBase> createState() => _DrawerBaseState();
}

class _DrawerBaseState extends State<DrawerBase> {
  

  @override
  Widget build(BuildContext context) {
    final usuarioController = context.watch<UsuarioController>();
    
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 116, 52, 184),
      child: ListView(
        children: [

          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 58, 17, 89),
            ),

            currentAccountPicture: 
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/perfil');
              },
              child:  CircleAvatar(
                          backgroundImage: usuarioController.dadosUsuario?['fotoPerfil'] != null
                            ? MemoryImage(base64Decode(usuarioController.dadosUsuario?['fotoPerfil']))
                            : null, // Decodifica o texto para Imagem!fit: BoxFit.cover,
                          child: (usuarioController.dadosUsuario?['fotoPerfil'] == null || usuarioController.dadosUsuario?['fotoPerfil']!.isEmpty)
                            ? const Icon(Icons.person, size: 50)
                            : null,
                    ),
            ),

            accountName: 
            InkWell(
              child: Text(usuarioController.dadosUsuario?['nome'] ?? 'Nome do Usuário'),
              onTap: () {
                Navigator.pushNamed(context, '/perfil');
              },
            ),
            
            accountEmail: 
                Row(
                  children: [
                    Icon(Icons.local_fire_department,color: const Color.fromARGB(255, 253, 122, 46),),
                    Text('${usuarioController.dadosUsuario?['ofensivaAtual'] ?? '0'} dias | ${usuarioController.dadosUsuario?['totalPontos'] ?? '0'} pontos'  , 
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    ),
                  ],
                ),
              

            
            
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [

                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/pagina_inicial');
                  },
                  child: TextoComLinha(texto: 'Meus grupos',)
                ),

                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/novo_grupo');
                  },
                  child: TextoComLinha(texto: 'Criar novo grupo',)
                ),

              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/encontrar_grupo');
                },
                child: TextoComLinha(texto: 'Entrar em grupo existente',)
              ),

              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/pesquisar_perfis');
                },
                child: TextoComLinha(texto: 'Pesquisar perfis'),
              ),

              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/analise_ia');
                },
                child: TextoComLinha(texto: 'Análise de IA'),
              ),
            
              SizedBox(
                height: 80,
              ),
              
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/configuracoes');
                },
                child: TextoComLinha(texto: 'Configurações',),
              ),
              
              InkWell(
                child: TextoComLinha(texto: 'Sobre',),
                onTap: () {
                  Navigator.pushNamed(context, '/sobre');
                },
              ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}