import 'package:flutter/material.dart';
import 'package:study_group/views/widgets/texto_com_linha.dart';

class DrawerBase extends StatefulWidget {
  const DrawerBase({super.key});

  @override
  State<DrawerBase> createState() => _DrawerBaseState();
}

class _DrawerBaseState extends State<DrawerBase> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 116, 52, 184),
      child: ListView(
        children: [

          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 58, 17, 89),
            ),

            currentAccountPicture: 
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/perfil');
              },
              child:  CircleAvatar(backgroundImage: NetworkImage('https://pbs.twimg.com/media/FsGrGIBXgAA1OQI.jpg',),),
            ),


            accountName: 
            InkWell(
              child: Text('Nome do Usuário'),
              onTap: () {
                Navigator.pushNamed(context, '/perfil');
              },
            ),
            
            accountEmail: Text('10 pontos', 
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/novo_grupo');
                  },
                  child: TextoComLinha(texto: 'Criar novo grupo',)
                ),

              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/encontrar_grupo');
                },
                child: TextoComLinha(texto: 'Entrar em grupo existente',)
              ),

              TextoComLinha(texto: 'Pesquisar perfis'),
            
              SizedBox(
                height: 80,
              ),
              
              TextoComLinha(texto: 'Configurações',),
              
              InkWell(
                child: TextoComLinha(texto: 'Sobre',),
                onTap: () {
                  Navigator.pushNamed(context, '/sobre');
                },
              ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}