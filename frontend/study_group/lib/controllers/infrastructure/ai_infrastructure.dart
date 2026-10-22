import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:study_group/controllers/gateways/ai_gateway.dart';
import 'package:study_group/controllers/gateways/postagem_gateway.dart';
import 'package:study_group/controllers/repositories/firebase/postagem_repository.dart';

class AiInfrastructure implements AiGateway {
  final PostagemGateway postagemRepository = FirebasePostagemRepository();
  
  // COLOQUE SUA CHAVE AQUI (Gere gratuitamente no Google AI Studio)
  final String apiKey = '-chave-oculta-'; 

  @override
  Future<Map<String, dynamic>> analisarUltimasPostagens(String userId) async {
    
    final querySnapshot = await postagemRepository.buscarUltimasPostagens(userId);

    if (querySnapshot.docs.isEmpty || querySnapshot.docs.length < 2) {
      throw Exception("Você ainda não possui postagens suficientes para gerar uma análise.");
    }
    // 2. Transforma os dados em um texto estruturado para a IA entender
    String dadosParaIA = "Aqui estão as minhas últimas sessões de estudo:\n\n";

    for (var doc in querySnapshot.docs) {
      final post = doc.data() as Map<String, dynamic>?;
      if (post == null) continue;
      dadosParaIA += "  Área de Estudo: ${post['areaEstudo']}\n";
      dadosParaIA += "  Título da postagem: ${post['titulo']}\n";
      dadosParaIA += "  Tempo de estudo: ${post['tempoEstudo']}\n";
      dadosParaIA += "  Descrição da postagem: ${post['descricao']}\n";
      dadosParaIA += "  Data da postagem: ${post['createdAt']?.toDate()?.toString() ?? 'Data não disponível'}\n\n";
    }

    // 3. O PROMPT: Pedimos para a IA analisar e devolver ESTRITAMENTE em JSON
    String prompt = '''
      Você é um coach de estudos inteligente. Analise os seguintes registros de estudo de um aluno e forneça insights. Assuma uma postura leve e encorajadora.
      
      $dadosParaIA
      
      Retorne a resposta EXATAMENTE no formato JSON abaixo, sem marcações de markdown (como ```json) ou textos adicionais:
      {
        "resumo": "Um breve resumo de 2 linhas sobre o perfil de estudo atual.",
        "pontosFortes": "O que o aluno está fazendo bem (1 linha).",
        "pontoDeMelhoria": "O que o aluno pode melhorar (1 linha).",
        "sugestao": "Uma dica prática e motivadora para os próximos estudos, ou oque estudar em seguida (1 linha)."
      }
    ''';

    // 4. Configura o modelo do Gemini
    final model = GenerativeModel(
      model: 'gemini-3.1-flash-lite', 
      apiKey: apiKey,
    );// Apenas para debug, lista os modelos disponíveis

    // 5. Envia para a IA
    final response = await model.generateContent([Content.text(prompt)]);
    String textoResposta = response.text ?? '{}';

    // 6. Limpeza de segurança (caso a IA insista em colocar ```json no texto)
    textoResposta = textoResposta.replaceAll('```json', '').replaceAll('```', '').trim();

    // 7. Converte a String JSON para um Map do Dart
    try {
      return jsonDecode(textoResposta);
    } catch (e) {
      throw Exception("Erro ao processar a resposta da IA. Tente novamente.");
    }
  }
}