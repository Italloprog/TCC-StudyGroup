import 'package:flutter/material.dart';

class CampoSelecao extends StatelessWidget {
  final String selected;
  final List<String> opcoes;
  final ValueChanged<String> onChanged; // Essa é a função que avisa a tela pai!

  const CampoSelecao({
    super.key, 
    required this.selected, 
    required this.opcoes,
    required this.onChanged, // Adicionado no construtor
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Selecione uma opção',
      onSelected: (value) {
        // Quando o usuário clicar em uma opção, disparamos a função onChanged
        // enviando o valor escolhido de volta para a tela de criação.
        onChanged(value);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      itemBuilder: (context) => [
        for (var opcao in opcoes)
          PopupMenuItem(
            value: opcao,
            child: Text(opcao, style: const TextStyle(fontSize: 17)),
          ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 217, 217, 217),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selected, // Exibe o valor que a tela pai enviou
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 25),
            const Icon(
              Icons.dehaze,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}