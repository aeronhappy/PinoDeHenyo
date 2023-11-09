import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/model/lesson_category_model.dart';

class LessonInfoPage extends StatefulWidget {
  final LessonCategoryModel item;
  const LessonInfoPage({super.key, required this.item});

  @override
  State<LessonInfoPage> createState() => _LessonInfoPageState();
}

class _LessonInfoPageState extends State<LessonInfoPage> {
  PaletteGenerator? paletteGenerator;

  @override
  void initState() {
    super.initState();
    generateColors(widget.item.image);
  }

  void generateColors(generatedImageUrl) async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
        Image.asset(generatedImageUrl).image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 350,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: paletteGenerator != null
                    ? paletteGenerator!.vibrantColor != null
                        ? paletteGenerator!.vibrantColor!.color
                        : Colors.red
                    : Colors.red,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20))),
            child: Center(
              child: Hero(
                  tag: '${widget.item.image}-tags',
                  child: Image.asset(widget.item.image)),
            ),
          ),
        ]),
      ),
    );
  }
}
