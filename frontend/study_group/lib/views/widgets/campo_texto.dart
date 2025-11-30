import 'package:flutter/material.dart';

class CampoTexto extends StatefulWidget {
  const CampoTexto({super.key, this.label, required this.controller,this.extendido = false, this.campoSenha = false, this.hint});

  final String? label;
  final bool extendido;
  final TextEditingController controller;
  final bool campoSenha;
  final String? hint;
  @override
  State<CampoTexto> createState() => _CampoTextoState();
}

class _CampoTextoState extends State<CampoTexto> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:  Column(
        children: [
          if (widget.label != null) Text(widget.label!, style: const TextStyle(fontSize: 20),),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
            child: TextFormField(
              maxLines: widget.extendido ? 2 : 1,
              obscureText: widget.campoSenha,
              controller: widget.controller,
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              decoration: InputDecoration(
                hintText: widget.hint ?? '',
                filled: true,
                fillColor: const Color.fromARGB(255, 217, 217, 217),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
          )
          
        ],
      ),
    );
  }
}