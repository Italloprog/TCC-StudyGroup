import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class GrandeCampoImagem extends StatefulWidget {
  const GrandeCampoImagem({super.key, required this.label, required this.onpressed, required this.imagem, this.imagemBase64, this.quadrado = false});

  final String label;
  final VoidCallback onpressed;
  final File? imagem;
  final String? imagemBase64;
  final bool quadrado;

  @override
  State<GrandeCampoImagem> createState() => _GrandeCampoImagemState();
}

class _GrandeCampoImagemState extends State<GrandeCampoImagem> {
  @override
  Widget build(BuildContext context) {
    return (widget.imagemBase64 != null && widget.imagem == null)
        ? Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: 320,
              height: widget.quadrado ? 300 : 150, // Ajuste a altura para nova postagem
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 217, 217, 217),
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                  image: MemoryImage(base64Decode(widget.imagemBase64!)),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      // ignore: deprecated_member_use
                      Colors.black.withOpacity(0.2),
                      BlendMode.darken,
                    ),
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
        :
    widget.imagem != null
        ? Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: 320,
              height: widget.quadrado ? 300 : 150, // Ajuste a altura para nova postagem
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 217, 217, 217),
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                  image: FileImage(widget.imagem!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      // ignore: deprecated_member_use
                      Colors.black.withOpacity(0.2),
                      BlendMode.darken,
                    ),
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
              height: widget.quadrado ? 300 : 150, // Ajuste a altura para nova postagem
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