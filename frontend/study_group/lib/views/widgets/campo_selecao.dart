import 'package:flutter/material.dart';

class CampoSelecao extends StatefulWidget {
  CampoSelecao({super.key, required this.selected, required this.opcoes });

  String selected;
  final List<String> opcoes;

  @override
  State<CampoSelecao> createState() => _CampoSelecaoState();
}

class _CampoSelecaoState extends State<CampoSelecao> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Selecione uma opção',
            onSelected: (value) {
              setState(() => widget.selected = value);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            itemBuilder: (context) => [
              for (var opcao in widget.opcoes)
                PopupMenuItem(
                    value: opcao,
                    child: Text(opcao, style: TextStyle(fontSize: 17),)),
            ],
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 217, 217, 217),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.selected,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 25),
                  Icon(
                    Icons.dehaze,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          );
  }
}