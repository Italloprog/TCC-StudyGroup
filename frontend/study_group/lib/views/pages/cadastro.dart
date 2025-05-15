import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/campo_texto.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  File? _imagem;
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController = TextEditingController();
  
  Future<void> _pegarImagemDaGaleria() async {
    final XFile? imagemSelecionada = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imagemSelecionada != null) {
      setState(() {
        _imagem = File(imagemSelecionada.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                      },
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                    ),
                  Text('Cadastrar-se', style: TextStyle(fontSize: 20),),
                  Spacer(),
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: 120,
                    height: 120,
                    child: ClipOval(
                      child: Image.asset('lib/assets/iconeApp2.png'),
                    ),
                  ),
                ],
              ),
              Text('IMAGEM DE PERFIL',style: TextStyle(fontSize: 18),),
              SizedBox(
                height: 10,
              ),
              IconButton(onPressed: (){},
               icon: Icon(Icons.add_a_photo),
               style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 217, 217, 217)),
                padding: WidgetStateProperty.all(EdgeInsets.all(40)),
      
                iconSize: WidgetStatePropertyAll(35)
                ),
              ),
              SizedBox(
                height: 10,
              ),
            
              CampoTexto(controller: _nomeController,label: 'NOME'),
              CampoTexto(controller: _emailController,label: 'EMAIL'),
              CampoTexto(controller: _senhaController,label: 'SENHA'),
              CampoTexto(controller: _confirmaSenhaController,label: 'CONFIRMAR SENHA'),

              SizedBox(
                height: 25,
              ),
              
              Botao(
                label: 'CRIAR CONTA',
                onPressed: (){
                  Navigator.pushNamed(context, '/login');
              }),
            ],
          ),
        ),
      ),
    );
  }
}