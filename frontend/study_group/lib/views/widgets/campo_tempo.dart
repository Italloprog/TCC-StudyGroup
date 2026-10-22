import 'package:flutter/material.dart';

class CampoTempo extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const CampoTempo({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () async {
        final String valorInicial = selected.trim();
        int totalMinutosInicial = 0;

        
        totalMinutosInicial = int.tryParse(
                RegExp(r'\d+').firstMatch(valorInicial)?.group(0) ?? '',
              ) ??
              0;
        

        // Abre o seletor de tempo nativo do Flutter
        final TimeOfDay? tempoEscolhido = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(
            hour: (totalMinutosInicial ~/ 60).clamp(0, 23),
            minute: (totalMinutosInicial % 60).clamp(0, 59),
          ),
          helpText: 'Selecione o tempo de estudo',
          cancelText: 'Cancelar',
          hourLabelText: 'Horas',
          minuteLabelText: 'Minutos',
          // Forçamos o formato 24h para facilitar a escolha de "horas e minutos" de estudo
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
        );

        if (tempoEscolhido != null) {
          // Convertendo horas e minutos escolhidos para o formato em String (ex: "90 minutos")
          final int totalMinutos = (tempoEscolhido.hour * 60) + tempoEscolhido.minute;
          
          // Dispara a função enviando o valor convertido para a tela pai
          onChanged('$totalMinutos minutos');
          
          // DICA: Se preferir exibir no formato "HH:mm", basta trocar a linha acima por:
          // final String formatado = '${tempoEscolhido.hour.toString().padLeft(2, '0')}:${tempoEscolhido.minute.toString().padLeft(2, '0')}';
          // onChanged(formatado);
        }
      },
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
              Icons.access_time, // Troquei o ícone dehaze para o de relógio, que faz mais sentido aqui!
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}