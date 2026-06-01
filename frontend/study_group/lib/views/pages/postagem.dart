import 'package:flutter/material.dart';
import 'package:study_group/views/widgets/scafolld_arrowback.dart';
import 'package:study_group/views/widgets/texto_com_linha.dart';

class PostagemPage extends StatefulWidget {
  const PostagemPage({super.key});

  @override
  State<PostagemPage> createState() => _PostagemPageState();
}

class _PostagemPageState extends State<PostagemPage> {
  final TextEditingController _perfisController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScafolldArrowback(
      epostagem: true,
      title: 'Postagem',
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://64.media.tumblr.com/cf6f3ccc3072950be60ffac9ca2da15b/53fb534a18ebefad-64/s1280x1920/104a2ebe9c1595425d9d32cc4e4b98f74736cab3.pnj',
                width: 320,
                height: 320,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    radius: 28,
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
                        'quinta-feira, jan. 8',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TextoComLinha(texto: 'Estudo de matemática'),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                'Descrição da postagem criada pelo usuario com alguns caracteres digitados no total, onde será feito uma observação sobre o estudo.',
                style: TextStyle(
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  //margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 116, 52, 184),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer,
                        color: Colors.white,
                      ),
                      Text('50 min'),
                    ],
                  ),
                ),
                Container(
                  //margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 116, 52, 184),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.school,
                        color: Colors.white,
                      ),
                      Text(' matemática'),
                    ],
                  ),
                ),
                Container(
                  //margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 116, 52, 184),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      Text('13 pontos'),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                    color: Color.fromARGB(255, 58, 17, 89),
                    borderRadius: BorderRadius.circular(15),
                  ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_fF60wLcJobL2nXnwxFtoSql0EKCXoTBjZQ&s'),
                    radius: 28,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Pessoa 2',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 190,
                        child: Text(
                          'Comentário sobre a postagem.',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                    color: Color.fromARGB(255, 58, 17, 89),
                    borderRadius: BorderRadius.circular(15),
                  ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://64.media.tumblr.com/0f7f8ecbb9df092d53582bf230e6e550/027836647fc0de15-c7/s1280x1920/830a5f592dd22d55f6d5f9210dec70fa8f32bb85.jpg'),
                    radius: 28,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Pessoa 3',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 190,
                        child: Text(
                          'Comentário legal sobre a postagem.',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
             padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                    color: Color.fromARGB(255, 58, 17, 89),
                    borderRadius: BorderRadius.circular(15),
                  ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://pbs.twimg.com/media/FSOGBy3XsAIxTiN.png'),
                    radius: 28,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Pessoa 4',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 190,
                        child: Text(
                          'Comentário muito legal sobre a postagem.',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
           
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 5,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://pbs.twimg.com/media/FsGrGIBXgAA1OQI.jpg'),
                    radius: 28,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _perfisController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 116, 52, 184),
                        hintStyle:
                            TextStyle(color: Color.fromARGB(200, 0, 0, 0)),
                        prefixIconColor: Color.fromARGB(255, 0, 0, 0),
                        hintText: 'Comentário...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 58, 17, 89),
                      ),
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          SafeArea(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
