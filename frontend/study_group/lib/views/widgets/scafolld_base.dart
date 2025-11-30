import 'package:flutter/material.dart';
import 'package:study_group/views/widgets/drawer_base.dart';

class ScafolldBase extends StatefulWidget {
  const ScafolldBase(
      {super.key, this.title, required this.body, this.egrupo = false});

  final String? title;
  final Widget body;
  final bool egrupo;
  @override
  State<ScafolldBase> createState() => _ScafolldBaseState();
}

class _ScafolldBaseState extends State<ScafolldBase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? 'StudyGroup',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 58, 17, 89),
        leading: Builder(
            builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: CircleAvatar(
                      backgroundImage: NetworkImage(
                    'https://pbs.twimg.com/media/FsGrGIBXgAA1OQI.jpg',
                  )),
                )),
        actions: widget.egrupo ? [
          Text('Faltam\n30 dias',
              style: TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center,),
          SizedBox(width: 10),
          Icon(Icons.date_range, color: Colors.white),
          SizedBox(width: 15),
        ] : null,
      ),
      drawer: DrawerBase(),
      body: Center(
        child: widget.body,
      ),
      floatingActionButton: widget.egrupo
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/nova_postagem');
              },
              backgroundColor: const Color.fromARGB(255, 116, 52, 184),
              shape: CircleBorder(),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
      bottomNavigationBar: widget.egrupo
          ? BottomAppBar(
              color: const Color.fromARGB(255, 58, 17, 89), // Fundo roxo escuro
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.manage_accounts,
                            color: Colors.white, size: 28),
                        Text(
                          "Detalhes",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.emoji_events, color: Colors.white, size: 28),
                        Text(
                          "Classificações",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
