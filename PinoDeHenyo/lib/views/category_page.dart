import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/colors/app_colors.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/repository/injection_container.dart';
import 'package:pino_de_henyo/views/lesson_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<QuestionControllerBloc>().add(GetListCategory());
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
            'assets/pino/background.png',
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              title: Hero(
                  transitionOnUserGestures: true,
                  tag: 'magaral-tag',
                  child: Text('MAG-ARAL', style: myFonts(Colors.white, 22))),
              backgroundColor: transparentBlackColor,
              elevation: 0),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: BlocBuilder<QuestionControllerBloc, QuestionControllerState>(
              builder: (context, state) {
                if (state is LoadedCategory) {
                  return Center(
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.all(40),
                      shrinkWrap: true,
                      itemCount: state.category.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (context) =>
                                              QuestionControllerBloc(
                                                  sharedPreferences: sl()),
                                        ),
                                      ],
                                      child: LessonPage(
                                          category: state.category[index]),
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: 60,
                              margin: EdgeInsets.all(2.5),
                              decoration: ShapeDecoration(
                                  shape: StadiumBorder(), color: Colors.white),
                              child: Center(
                                child: Text(
                                  state.category[index],
                                  style: GoogleFonts.titanOne(
                                    fontSize: 22.5,
                                    decoration: TextDecoration.none,
                                    color: Colors.brown,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ],
    );
  }
}
