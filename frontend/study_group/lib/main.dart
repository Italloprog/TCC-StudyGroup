import 'package:flutter/material.dart';
import 'package:study_group/views/pages/cadastro.dart';
import 'package:study_group/views/pages/login.dart';
import 'package:study_group/views/pages/pagina_inicial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Group',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        fontFamily: 'Josefin',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 68, 68, 68),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
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
      },

    );
  }
}