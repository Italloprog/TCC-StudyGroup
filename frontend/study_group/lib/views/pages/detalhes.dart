import 'package:flutter/material.dart';
import 'package:study_group/views/widgets/botao.dart';
import 'package:study_group/views/widgets/scafolld_arrowback.dart';
import 'package:study_group/views/widgets/texto_com_linha.dart';

class DetalhesPage extends StatefulWidget {
  const DetalhesPage({super.key});

  @override
  State<DetalhesPage> createState() => _DetalhesPageState();
}

class _DetalhesPageState extends State<DetalhesPage> {
  @override
  Widget build(BuildContext context) {
    return ScafolldArrowback(
        title: 'Detalhes',
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Grupo 1',
                style: TextStyle(
                  fontSize: 24,
                  decoration: TextDecoration.underline,
                  decorationThickness: 0.5,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 1.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 116, 52, 184),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 19.5,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://pbs.twimg.com/media/FsGrGIBXgAA1OQI.jpg'),
                      radius: 35,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Pessoa 1',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Admin do grupo',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 350,
                child: Text(
                  'Descrição do grupo inserida anteriormente com caracteres digitados pelo usuário descrevendo grupo e seu objetivo.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextoComLinha(texto: 'Código de convite: HT67IB43', tamanho: 18,),
                  Icon(Icons.share_outlined, color: Colors.white,size: 30,),
                ],
              ),
              
              SizedBox(
                height: 10,
              ),
              TextoComLinha(texto: 'Modo de pontuação: Dias Ativos', tamanho: 18,),
              SizedBox(
                height: 10,
              ),
              TextoComLinha(texto: 'Periodo total : 31 dias.', tamanho: 18,),
              SizedBox(
                height: 10,
              ),
              TextoComLinha(texto: 'Quantidade de membros: 4.', tamanho: 18,),
              SizedBox(
                height: 10,
              ),
              TextoComLinha(texto: 'Total de postagens: 12.', tamanho: 18,),

              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Botao(label:'🚫 Deixar grupo', onPressed: (){Navigator.pushNamed(context, '/pagina_inicial');}, padding_v: 15,),],
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Botao(label:'⚙️ Editar grupo', onPressed: (){Navigator.pushNamed(context, '/editar_grupo');}, padding_v: 15,),],
              )
            ],
          ),
        ));
  }
}
