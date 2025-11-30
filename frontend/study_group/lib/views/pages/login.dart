import 'package:flutter/material.dart';
import 'package:study_group/views/widgets/Icone_grande_app.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/campo_texto.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Center(
          child: Column(
            children: [
              Text('Bem-vindo ao StudyGroup', style: TextStyle(fontSize: 20),),
              
              IconeGrandeApp(),

              CampoTexto(controller: _emailController, label: 'EMAIL'),

              CampoTexto(controller: _senhaController, label: 'SENHA', campoSenha: true,),

              SizedBox(
                height: 90,
              ),
        
              Botao(label: 'LOGIN', onPressed: (){Navigator.pushNamed(context, '/pagina_inicial');},),
        
              SizedBox(
                height: 20,
              ),
        
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/cadastro');
                },
                child: Text('CADASTRE-SE', 
                style: TextStyle( 
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                  shadows: [Shadow(offset: Offset(2, 2), blurRadius: 2.0, color: Colors.black,),
                ],),),
              ),
              
              
            ],
          ),
        ),
      ),

    );
  }
}