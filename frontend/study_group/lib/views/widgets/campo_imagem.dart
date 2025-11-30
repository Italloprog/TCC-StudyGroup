import 'package:flutter/material.dart';

class CampoImagem extends StatefulWidget {
  const CampoImagem({super.key});

  @override
  State<CampoImagem> createState() => _CampoImagemState();
}

class _CampoImagemState extends State<CampoImagem> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
                onPressed: (){},
                icon: Icon(Icons.add_a_photo),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 217, 217, 217)),
                  padding: WidgetStateProperty.all(EdgeInsets.all(40)),
      
                  iconSize: WidgetStatePropertyAll(35),
                ),
              );
  }
}