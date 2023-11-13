import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';

class LevelPage extends StatefulWidget {
  final String fromPage;
  const LevelPage({super.key, required this.fromPage});

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  int levelDone = 0;

  @override
  void initState() {
    super.initState();
    if (widget.fromPage == 'MAGSULAT') {
      context.read<QuestionControllerBloc>().add(GetWritingLevel());
    }
    if (widget.fromPage == 'MAGBASA') {
      context.read<QuestionControllerBloc>().add(GetReadingLevel());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionControllerBloc, QuestionControllerState>(
      listener: (context, state) {
        if (state is LoadedWritingLevel) {
          setState(() {
            levelDone = state.myLevel;
          });
        }
        if (state is LoadedReadingLevel) {
          setState(() {
            levelDone = state.myLevel;
          });
        }
      },
      child: Scaffold(
          backgroundColor: lightPrimarybgColor,
          appBar: AppBar(
            title: Text('Choose level'),
            backgroundColor: lightPrimarybgColor,
            iconTheme: Theme.of(context).iconTheme,
            elevation: 0,
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 90,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: 10,
              itemBuilder: (BuildContext ctx, index) {
                return InkWell(
                  onTap: levelDone >= index
                      ? () {
                          if (widget.fromPage == 'MAGSULAT') {
                            context
                                .read<QuestionControllerBloc>()
                                .add(ChangeWritingLevel(levelSelected: index));
                          }
                          if (widget.fromPage == 'MAGBASA') {
                            context
                                .read<QuestionControllerBloc>()
                                .add(ChangeReadingLevel(levelSelected: index));
                          }

                          Navigator.pop(context);
                        }
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                        color: levelDone >= index
                            ? Colors.brown
                            : Colors.brown.withOpacity(.5),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                        child: levelDone >= index
                            ? Text(
                                'Level ${index + 1}',
                              )
                            : Icon(
                                Icons.lock,
                                color: Colors.brown,
                              )),
                  ),
                );
              },
            ),
          )),
    );
  }
}
