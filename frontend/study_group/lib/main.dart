import 'package:flutter/material.dart';
import 'package:study_group/views/pages/cadastro.dart';
import 'package:study_group/views/pages/configuracoes.dart';
import 'package:study_group/views/pages/criar_grupo.dart';
import 'package:study_group/views/pages/editar_grupo.dart';
import 'package:study_group/views/pages/encontrar_grupo.dart';
import 'package:study_group/views/pages/grupo.dart';
import 'package:study_group/views/pages/login.dart';
import 'package:study_group/views/pages/nova_postagem.dart';
import 'package:study_group/views/pages/novo_grupo.dart';
import 'package:study_group/views/pages/pagina_inicial.dart';
import 'package:study_group/views/pages/perfil.dart';
import 'package:study_group/views/pages/pesquisar_perfis.dart';
import 'package:study_group/views/pages/sobre.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyGroup',
      //themeMode: ThemeMode.dark,
      //darkTheme: ThemeData.dark(),
      theme: ThemeData(
        fontFamily: 'Josefin',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 68, 68, 68),
        canvasColor: Color.fromARGB(255, 217, 217, 217),
        
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color.fromARGB(255, 187, 177, 177)),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          labelMedium: TextStyle(color: Colors.white),
          labelSmall: TextStyle(color: Colors.white),
          labelLarge: TextStyle(color: Colors.white),
          
        ),
      ),
      debugShowCheckedModeBanner: false,

      initialRoute: '/login',
      routes: {
        '/login' : (context) => const LoginPage(),
        '/cadastro' : (context) => const CadastroPage(),
        '/pagina_inicial' : (context) => const PaginaInicial(),
        '/sobre' : (context) => const SobrePage(),
        '/perfil' : (context) => const PerfilPage(),
        '/novo_grupo' : (context) => const NovoGrupoPage(),
        '/encontrar_grupo' : (context) => const EncontrarGrupoPage(),
        '/pesquisar_perfis' : (context) => const PesquisarPerfisPage(),
        '/configuracoes' : (context) => const ConfiguracoesPage(),
        '/criar_grupo' : (context) => const CriarGrupoPage(),
        '/grupo' : (context) => const GrupoPage(),
        '/nova_postagem' : (context) => const NovaPostagemPage(),
        '/editar_grupo' : (context) => const EditarGrupoPage(),
      },

    );
  }
}