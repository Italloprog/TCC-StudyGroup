import 'package:flutter/material.dart';

class ScafolldArrowback extends StatefulWidget {
  const ScafolldArrowback({super.key, this.title, required this.body, this.egrupo = false, this.epostagem = false});
  final String? title;
  final Widget body;
  final bool egrupo;
  final bool epostagem;
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
        actions: widget.egrupo || widget.epostagem ? [
          if (widget.egrupo) ...[
            Text('Faltam\n30 dias',
          style: TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.center,),
            SizedBox(width: 10),
            Icon(Icons.date_range, color: Colors.white),
            SizedBox(width: 15),
          ],
          if (widget.epostagem)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: () {},
            ),
        ] : null,
        

      ),
      
      body: Center(
        child: widget.body,
      ));
  }
}