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
              'https://scontent.fthe23-1.fna.fbcdn.net/v/t1.6435-9/170047770_205765511345241_4912460674495783534_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=833d8c&_nc_ohc=AWOFFqqtPQEQ7kNvwEUyjWU&_nc_oc=AdkV-CJdxrrpMIgDH80RwmqS8qQ1uRwoYabFQKvClAKEobEY65qOFEh6WhbGkrADb5LZT4MoSAkqg9s6jbaQjDCi&_nc_zt=23&_nc_ht=scontent.fthe23-1.fna&_nc_gid=5etFKMh9FtA3GG7JiSwTBw&oh=00_AfjZU1Z6ECasUUL6nIBRMSnlYzuT1tRxWEwM5V_vDNjUgQ&oe=6952F190',
              width: 400,
              height: 150,
              fit: BoxFit.cover,
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
