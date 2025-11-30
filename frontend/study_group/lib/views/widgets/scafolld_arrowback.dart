import 'package:flutter/material.dart';

class ScafolldArrowback extends StatefulWidget {
  const ScafolldArrowback({super.key, this.title, required this.body});
  final String? title;
  final Widget body;
  @override
  State<ScafolldArrowback> createState() => _ScafolldArrowbackState();
}

class _ScafolldArrowbackState extends State<ScafolldArrowback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? '', style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 58, 17, 89),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      
      body: Center(
        child: widget.body,
      ));
  }
}