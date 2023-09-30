import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_app/bloc/question/bloc/question_bloc.dart';
import 'package:youtube_app/designs/fonts/text_style.dart';
import 'package:youtube_app/views/quiz_category_page.dart';
import 'package:youtube_app/views/video_page.dart';
import '../repository/injection_container.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            body: PageView(
                controller: pageController,
                onPageChanged: (newIndex) {
                  setState(() {
                    currentIndex = newIndex;
                  });
                },
                children: [
                  MultiBlocProvider(providers: [
                    BlocProvider(create: (context) => sl<QuestionBloc>()),
                  ], child: const QuizCategoryPage()),
                  const VideoPage()
                ]),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: const ShapeDecoration(
                shape: StadiumBorder(),
                color: Colors.red,
              ),
              child: BottomNavigationBar(
                iconSize: 25,
                showUnselectedLabels: false,
                selectedLabelStyle: bodyMediumDark,
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.white,
                currentIndex: currentIndex,
                elevation: 0,
                backgroundColor: Colors.transparent,
                onTap: (index) {
                  setState(() {
                    pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  });
                },
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      label: 'Quiz',
                      icon: Icon(currentIndex == 0
                          ? Icons.quiz
                          : Icons.quiz_outlined)),
                  BottomNavigationBarItem(
                      label: 'Tutorials',
                      icon: Icon(currentIndex == 1
                          ? Icons.movie
                          : Icons.movie_outlined)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
