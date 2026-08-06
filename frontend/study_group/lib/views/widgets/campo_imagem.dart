import 'dart:io';
import 'package:flutter/material.dart';

class CampoImagem extends StatefulWidget {
  const CampoImagem({super.key, required this.onpressed, required this.imagem});

  final VoidCallback onpressed;
  final File? imagem;
  @override
  State<CampoImagem> createState() => _CampoImagemState();
}

class _CampoImagemState extends State<CampoImagem> {
  @override
  Widget build(BuildContext context) {
    return widget.imagem != null
        ? InkWell(
          onTap: widget.onpressed,
          child: CircleAvatar(
            radius: 60,
            backgroundImage: FileImage(widget.imagem!),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.2),
              ),
              child: Center(
                child: Icon(
                  Icons.edit,
                  color: const Color.fromARGB(255, 116, 52, 184),
                  size: 35,
                ),
              ),
            ),
          ))
        :
        IconButton(
                onPressed: widget.onpressed,
                icon: Icon(Icons.add_a_photo),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 217, 217, 217)),
                  padding: WidgetStateProperty.all(EdgeInsets.all(40)),
      
                  iconSize: WidgetStatePropertyAll(35),
                ),
              );
  }
}