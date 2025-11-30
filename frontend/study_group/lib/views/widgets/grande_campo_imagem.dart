import 'package:flutter/material.dart';

class GrandeCampoImagem extends StatefulWidget {
  const GrandeCampoImagem({super.key, required this.label});

  final String label;

  @override
  State<GrandeCampoImagem> createState() => _GrandeCampoImagemState();
}

class _GrandeCampoImagemState extends State<GrandeCampoImagem> {
  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: 350,
              height: 150,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 217, 217, 217),
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle),
              child: InkWell(
                
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.label,
                      style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 116, 52, 184)),
                    ),
                    Icon(
                      Icons.add_a_photo,
                      size: 35,
                    ),
                  ],
                ),
              ));
  }
}