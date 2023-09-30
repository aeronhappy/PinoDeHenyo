import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youtube_app/designs/fonts/text_style.dart';

import '../designs/colors/app_colors.dart';
import '../model/onboard_model.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: pageController,
          itemCount: onboardModel.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(onboardModel[index].img),
                  Text(
                    onboardModel[index].text,
                    style: titleLargeLight,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    onboardModel[index].desc,
                    style: labelLargeDark,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          }),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * .2,
        color: secondaryColor,
        child: Center(
            child: Row(
          children: [
            SmoothPageIndicator(
              controller: pageController,
              effect: const WormEffect(
                  dotHeight: 5,
                  dotWidth: 15,
                  activeDotColor: Colors.red,
                  spacing: 5),
              count: onboardModel.length,
              onDotClicked: ((index) => pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear)),
            ),
            FloatingActionButton(
                onPressed: () {}, child: const Icon(Icons.play_arrow)),
          ],
        )),
      ),
    );
  }
}
