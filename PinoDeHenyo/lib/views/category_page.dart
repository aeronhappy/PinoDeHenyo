import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pino_de_henyo/bloc/question_controller/bloc/question_controller_bloc.dart';
import 'package:pino_de_henyo/designs/fonts/text_style.dart';
import 'package:pino_de_henyo/repository/injection_container.dart';
import 'package:pino_de_henyo/views/lesson_page.dart';
import 'package:pino_de_henyo/widgets/custom_back_button.dart';

class CategoryPage extends StatefulWidget {
  final String title;
  const CategoryPage({super.key, required this.title});

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
            'assets/pino/sky_bg.png',
            fit: BoxFit.fitHeight,
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBackButton(text: widget.title),
                  SizedBox(height: 50),
                  Stack(
                    children: [
                      Container(
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Pumili ng kategorya!',
                              style: bodyBlack.copyWith(
                                  fontSize: 27,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 80)
                          ],
                        ),
                      ),
                      Positioned(
                          right: -20,
                          top: 10,
                          bottom: -10,
                          child: Image.asset("assets/pino/pino_medium.png")),
                    ],
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<QuestionControllerBloc, QuestionControllerState>(
                    builder: (context, state) {
                      if (state is LoadedCategory) {
                        return Expanded(
                            child: GridView.builder(
                                padding: EdgeInsets.all(10),
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20),
                                itemCount: state.category.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    highlightColor: Colors.primaries[index],
                                    splashColor: Colors.primaries[index],
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
                                                          sharedPreferences:
                                                              sl()),
                                                ),
                                              ],
                                              child: LessonPage(
                                                  category:
                                                      state.category[index]),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Material(
                                        elevation: 5,
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.primaries[index]
                                                  .withOpacity(.8)),
                                          child: Center(
                                            child: Hero(
                                              tag:
                                                  "${state.category[index]}-tag",
                                              child: Text(
                                                state.category[index],
                                                textAlign: TextAlign.center,
                                                style: smallTitleWhite(true),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }));
                      }
                      return CircularProgressIndicator();
                    },
                  )
                ],
              ),
            ),
            // body: Container(
            //   color: red,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       CustomBackButton(text: widget.title),
            //       Padding(
            //         padding: const EdgeInsets.all(20.0),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Container(
            //               child: Text(
            //                 'Pumili ng kategorya.',
            //                 style: bodyBlack.copyWith(
            //                     fontSize: 30,
            //                     color: Colors.black,
            //                     fontWeight: FontWeight.bold,
            //                     letterSpacing: -1),
            //               ),
            //             ),
            //             BlocBuilder<QuestionControllerBloc,
            //                 QuestionControllerState>(
            //               builder: (context, state) {
            //                 if (state is LoadedCategory) {
            //                   var category = state.category;

            //                   return Expanded(
            //                     child: GridView.builder(
            //                         gridDelegate:
            //                             const SliverGridDelegateWithMaxCrossAxisExtent(
            //                                 maxCrossAxisExtent: 150,
            //                                 childAspectRatio: 2.5,
            //                                 crossAxisSpacing: 10,
            //                                 mainAxisSpacing: 10),
            //                         itemCount: category.length + 4,
            //                         itemBuilder: (BuildContext ctx, i) {
            //                           return InkWell(
            //                             borderRadius: BorderRadius.circular(12),
            //                             onTap: i > category.length - 1
            //                                 ? null
            //                                 : () {
            //                                     Navigator.push(
            //                                       context,
            //                                       MaterialPageRoute(
            //                                         builder: (context) {
            //                                           return MultiBlocProvider(
            //                                             providers: [
            //                                               BlocProvider(
            //                                                 create: (context) =>
            //                                                     QuestionControllerBloc(
            //                                                         sharedPreferences:
            //                                                             sl()),
            //                                               ),
            //                                             ],
            //                                             child: LessonPage(
            //                                                 category: state
            //                                                     .category[i]),
            //                                           );
            //                                         },
            //                                       ),
            //                                     );
            //                                   },
            //                             child: Material(
            //                               elevation: 3,
            //                               borderRadius: BorderRadius.circular(12),
            //                               child: Container(
            //                                 padding: EdgeInsets.all(20),
            //                                 decoration: BoxDecoration(
            //                                     color: Colors.primaries[i %
            //                                             Colors.primaries.length]
            //                                         .withOpacity(.5),
            //                                     borderRadius:
            //                                         BorderRadius.circular(12)),
            //                                 child: Center(
            //                                   child: Text(
            //                                     i > category.length - 1
            //                                         ? '$i'
            //                                         : state.category[i],
            //                                     textAlign: TextAlign.center,
            //                                     style: largeTitleWhite(true)
            //                                         .copyWith(
            //                                       fontSize: 20,
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                           );
            //                         }),
            //                   );
            //                 }
            //                 return Container();
            //               },
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ),
        ),
      ],
    );
  }
}
