import 'package:flutter/material.dart';
import 'package:study_group/views/widgets/card_postagem.dart';
import 'package:study_group/views/widgets/scafolld_base.dart';

class GrupoPage extends StatefulWidget {
  const GrupoPage({super.key});

  @override
  State<GrupoPage> createState() => _GrupoPageState();
}

class _GrupoPageState extends State<GrupoPage> {
  @override
  Widget build(BuildContext context) {
    return ScafolldBase(
      egrupo: true,
      title: 'Grupo 1',
      body: SingleChildScrollView(
        child: Column(
        
        children: [
          SizedBox(height: 10,),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://rukminim2.flixcart.com/image/480/640/xif0q/book/4/e/7/jujutsu-kaisen-the-official-anime-guide-season-1-original-imahy5khvngzgc6p.jpeg?q=90',
              width: 320,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 320,
                  height: 150,
                  color: Colors.grey,
                  child: Icon(Icons.image_not_supported),
                );
              },
            ),
          ),
          SizedBox(height: 10,),
          Text(
            'ultimas postagens',
            style: TextStyle(fontSize: 15, color: Colors.grey,),
          ),
          
          CardPostagem(imagem: 'https://64.media.tumblr.com/cf6f3ccc3072950be60ffac9ca2da15b/53fb534a18ebefad-64/s1280x1920/104a2ebe9c1595425d9d32cc4e4b98f74736cab3.pnj', titulo: 'Estudo de matemática', autor: 'Pessoa 1', data: '8 jan.'),
          CardPostagem(imagem: 'https://64.media.tumblr.com/cf6f3ccc3072950be60ffac9ca2da15b/53fb534a18ebefad-64/s1280x1920/104a2ebe9c1595425d9d32cc4e4b98f74736cab3.pnj', titulo: 'Estudo de fisica', autor: 'Pessoa 2', data: '9 jan.'),
          CardPostagem(imagem: 'https://64.media.tumblr.com/cf6f3ccc3072950be60ffac9ca2da15b/53fb534a18ebefad-64/s1280x1920/104a2ebe9c1595425d9d32cc4e4b98f74736cab3.pnj', titulo: 'Estudo de programação', autor: 'Pessoa 2', data: '9 jan.'),
          CardPostagem(imagem: 'https://64.media.tumblr.com/cf6f3ccc3072950be60ffac9ca2da15b/53fb534a18ebefad-64/s1280x1920/104a2ebe9c1595425d9d32cc4e4b98f74736cab3.pnj', titulo: 'Estudo de biologia', autor: 'Pessoa 3', data: '13 jan.'),
          CardPostagem(imagem: 'https://64.media.tumblr.com/cf6f3ccc3072950be60ffac9ca2da15b/53fb534a18ebefad-64/s1280x1920/104a2ebe9c1595425d9d32cc4e4b98f74736cab3.pnj', titulo: 'Estudo de medicina', autor: 'Pessoa 3', data: '10 jan.'),
          CardPostagem(imagem: 'https://64.media.tumblr.com/cf6f3ccc3072950be60ffac9ca2da15b/53fb534a18ebefad-64/s1280x1920/104a2ebe9c1595425d9d32cc4e4b98f74736cab3.pnj', titulo: 'Estudo de direito', autor: 'Pessoa 1', data: '11 jan.'),
          CardPostagem(imagem: 'https://64.media.tumblr.com/cf6f3ccc3072950be60ffac9ca2da15b/53fb534a18ebefad-64/s1280x1920/104a2ebe9c1595425d9d32cc4e4b98f74736cab3.pnj', titulo: 'Estudo de matemática', autor: 'Pessoa 2', data: '12 jan.'),
          SizedBox(height: 30,),
        ],
      ),
      ),
      
    );
  }
}
