import 'package:flutter/material.dart';
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
              Text('Bem-vindo ao StudyGroup'),
              Container(
                margin: EdgeInsets.all(10),
                width: 200,
                height: 200,
                child: ClipOval(child: Image.asset('lib/assets/iconeApp2.png',)),
              ),
              
              CampoTexto(controller: _emailController, label: 'EMAIL'),
        
              CampoTexto(controller: _senhaController, label: 'SENHA'),
        
              SizedBox(
                height: 90,
              ),
        
              Botao(label: 'LOGIN', onPressed: (){}),
        
              SizedBox(
                height: 20,
              ),
        
              InkWell(
                onTap: (){},
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