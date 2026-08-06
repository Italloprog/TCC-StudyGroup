import 'dart:io';

import 'package:flutter/material.dart';

class GrandeCampoImagem extends StatefulWidget {
  const GrandeCampoImagem({super.key, required this.label, required this.onpressed, required this.imagem});

  final String label;
  final VoidCallback onpressed;
  final File? imagem;

  @override
  State<GrandeCampoImagem> createState() => _GrandeCampoImagemState();
}

class _GrandeCampoImagemState extends State<GrandeCampoImagem> {
  @override
  Widget build(BuildContext context) {
    return widget.imagem != null
        ? Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: 320,
              height: 150,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 217, 217, 217),
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                  image: FileImage(widget.imagem!),
                  fit: BoxFit.cover,
                ),),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: widget.onpressed,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                      Icon(
                        Icons.edit,
                        color: const Color.fromARGB(255, 116, 52, 184),
                        size: 35,
                      ),
                  ],
                ),
              )
        )
        : Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: 320,
              height: 150,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 217, 217, 217),
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle),
              child: InkWell(
                
                onTap: widget.onpressed,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.label,
                      style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 116, 52, 184)),
                    ),
                    Icon(
                      Icons.add_a_photo,
                      size: 35,
                    ),
                  ],
                ),
              ));
  }
}