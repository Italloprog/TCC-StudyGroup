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
  late bool _ocultarSenha;

  @override
  void initState() {
    super.initState();
    // 2. Inicializa a variável com base no que foi passado ao widget
    _ocultarSenha = widget.campoSenha;
  }
  
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
              obscureText: _ocultarSenha,
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
                suffixIcon: widget.campoSenha
                    ? IconButton(
                        icon: Icon(
                          // Muda o ícone dependendo do estado
                          _ocultarSenha ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // 5. Atualiza a tela invertendo o valor da visibilidade
                          setState(() {
                            _ocultarSenha = !_ocultarSenha;
                          });
                        },
                      )
                    : null,
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