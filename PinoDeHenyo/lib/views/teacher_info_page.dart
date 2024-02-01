import 'package:flutter/material.dart';
import 'package:pino_de_henyo/model/teacher_model.dart';

class TeacherInfoPage extends StatefulWidget {
  final TeacherModel teacherModel;
  const TeacherInfoPage({super.key, required this.teacherModel});

  @override
  State<TeacherInfoPage> createState() => _TeacherInfoPageState();
}

class _TeacherInfoPageState extends State<TeacherInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        top: 0,
        child: Image.asset(
          'assets/pino/14.png',
          fit: BoxFit.fitHeight,
        ),
      ),
    ]);
  }
}
