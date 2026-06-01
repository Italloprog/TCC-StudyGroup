import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_group/controllers/providers/autenticacao_controller.dart';
import 'package:study_group/views/pages/cadastro.dart';
import 'package:study_group/views/pages/classificacoes.dart';
import 'package:study_group/views/pages/configuracoes.dart';
import 'package:study_group/views/pages/criar_grupo.dart';
import 'package:study_group/views/pages/detalhes.dart';
import 'package:study_group/views/pages/editar_grupo.dart';
import 'package:study_group/views/pages/encontrar_grupo.dart';
import 'package:study_group/views/pages/grupo.dart';
import 'package:study_group/views/pages/login.dart';
import 'package:study_group/views/pages/nova_postagem.dart';
import 'package:study_group/views/pages/novo_grupo.dart';
import 'package:study_group/views/pages/pagina_inicial.dart';
import 'package:study_group/views/pages/perfil.dart';
import 'package:study_group/views/pages/pesquisar_perfis.dart';
import 'package:study_group/views/pages/postagem.dart';
import 'package:study_group/views/pages/sobre.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Garante que os bindings do Flutter estejam prontos antes do Firebase
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        //Injetamos o Controller usando ChangeNotifierProvider.
        ChangeNotifierProvider(
          create: (context) => AutenticacaoController(),
        ),
      ],
      child: const MyApp(), // Seu widget principal
    ),
  );
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

        dialogTheme: DialogTheme(
          backgroundColor: const Color.fromARGB(255, 58, 17, 89),// Cor de fundo do AlertDialog
          elevation: 8, // Sombra do diálogo
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Bordas arredondadas
          ),
          titleTextStyle: const TextStyle(
              color: Colors.white, // Cor do título
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
         
        ),

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
        '/login': (context) => const LoginPage(),
        '/cadastro': (context) => const CadastroPage(),
        '/pagina_inicial': (context) => const PaginaInicial(),
        '/sobre': (context) => const SobrePage(),
        '/perfil': (context) => const PerfilPage(),
        '/novo_grupo': (context) => const NovoGrupoPage(),
        '/encontrar_grupo': (context) => const EncontrarGrupoPage(),
        '/pesquisar_perfis': (context) => const PesquisarPerfisPage(),
        '/configuracoes': (context) => const ConfiguracoesPage(),
        '/criar_grupo': (context) => const CriarGrupoPage(),
        '/grupo': (context) => const GrupoPage(),
        '/nova_postagem': (context) => const NovaPostagemPage(),
        '/editar_grupo': (context) => const EditarGrupoPage(),
        '/classificacoes': (context) => const ClassificacoesPage(),
        '/postagem': (context) => const PostagemPage(),
        '/detalhes': (context) => const DetalhesPage(),
      },
    );
  }
}
