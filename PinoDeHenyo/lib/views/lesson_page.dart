import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/views/lesson_info_page.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';

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
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 0,
          child: Image.asset(
            'assets/pino/sky_bg.png',
            fit: BoxFit.fitHeight,
          ),
        ),
        SafeArea(
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBackButton(
                      text: widget.category,
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: BlocBuilder<QuestionControllerBloc,
                          QuestionControllerState>(
                        builder: (context, state) {
                          if (state is LoadedLessonByCategory) {
                            return ListView.builder(
                              itemCount: state.categoryLessonList.length,
                              itemBuilder: ((context, index) {
                                var item = state.categoryLessonList[index];
                                return Container(
                                    height: 180,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 40),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            highlightColor: item.color,
                                            splashColor: item.color,
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return LessonInfoPage(
                                                        item: item);
                                                  },
                                                ),
                                              );
                                              Feedback.forTap(context);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(2),
                                              child: Material(
                                                elevation: 5,
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: item.color!
                                                          .withOpacity(.9),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  height: double.infinity,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 55),
                                                      Expanded(
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Text(item.title,
                                                                  style:
                                                                      largeTitleWhite(
                                                                          true)),
                                                              SizedBox(
                                                                  height: 10),
                                                              Text(
                                                                  item
                                                                      .description,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      bodyWhite),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 20,
                                          bottom: 20,
                                          left: -10,
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
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
