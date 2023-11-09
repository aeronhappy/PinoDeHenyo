import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/views/lesson_info_page.dart';

class LessonPage extends StatefulWidget {
  final String category;
  const LessonPage({super.key, required this.category});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<QuestionControllerBloc>()
        .add(GetLessonByCategory(category: widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightPrimarybgColor,
        appBar: AppBar(
          title: Text('MAG-ARAL', style: titleMediumLight),
          backgroundColor: lightPrimarybgColor,
          iconTheme: Theme.of(context).iconTheme,
          elevation: 0,
        ),
        body: BlocBuilder<QuestionControllerBloc, QuestionControllerState>(
          builder: (context, state) {
            if (state is LoadedLessonByCategory) {
              return ListView.builder(
                itemCount: state.categoryLessonList.length,
                itemBuilder: ((context, index) {
                  var item = state.categoryLessonList[index];
                  return Container(
                      height: 180,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return LessonInfoPage(item: item);
                                  },
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 40),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(20)),
                              height: double.infinity,
                              child: Row(
                                children: [
                                  SizedBox(width: 60),
                                  Expanded(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            item.title,
                                            style: myFonts(Colors.white, 22),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            item.description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: googleFonts(16, Colors.white,
                                                FontWeight.normal),
                                          ),
                                          SizedBox(height: 20),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 25,
                            bottom: 25,
                            left: 0,
                            child: Hero(
                              tag: '${item.image}-tags',
                              child: Image.asset(
                                item.image,
                                height: 150,
                              ),
                            ),
                          )
                        ],
                      ));
                }),
              );
            }
            return Container();
          },
        ));
  }
}
