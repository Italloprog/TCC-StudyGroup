import 'package:flutter/material.dart';
import 'package:study_group/views/widgets/drawer_base.dart';

class ScafolldBase extends StatefulWidget {
  const ScafolldBase({super.key, this.title, this.body,});

  final String? title;
  final Widget? body;

  @override
  State<ScafolldBase> createState() => _ScafolldBaseState();
}

class _ScafolldBaseState extends State<ScafolldBase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'StudyGroup', style: const TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 58, 17, 89),
      ),
      drawer: DrawerBase(),
      body: Center(
        child: widget.body,
      ),
    );
  }
}