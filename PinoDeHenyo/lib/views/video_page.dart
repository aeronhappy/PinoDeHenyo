import 'dart:math';

import 'package:flutter/material.dart';
import 'package:youtube_app/designs/colors/app_colors.dart';
import 'package:youtube_app/designs/fonts/text_style.dart';
import 'package:youtube_app/views/videoplayerpage.dart';

import '../model/cartoons_model.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  int randomNumber = 0;
  @override
  void initState() {
    super.initState();
    randomNumber = Random().nextInt(cartoonPlaylist.length);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => YoutubeVideoPlayerPage(
                          cartoonsModel: cartoonPlaylist[randomNumber],
                        )));
              },
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.network(
                      cartoonPlaylist[randomNumber].img,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        color: transparentBlackColor,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartoonPlaylist[randomNumber].text,
                              style: titleMediumDark,
                            ),
                            Text(
                              cartoonPlaylist[randomNumber].desc,
                              style: bodySmallDark,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ))
                ],
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
            child: Text(
              'New Story',
              style: titleLargeLight,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cartoonPlaylist.length,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                itemBuilder: (_, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => YoutubeVideoPlayerPage(
                                  cartoonsModel: cartoonPlaylist[index],
                                )));
                      },
                      child: Card(
                        elevation: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: SizedBox(
                            height: 180,
                            width: 150,
                            child: Image.network(
                              cartoonPlaylist[index].img,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ));
                }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
            child: Text(
              'Action Story',
              style: titleLargeLight,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cartoonPlaylist.length,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                itemBuilder: (_, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => YoutubeVideoPlayerPage(
                                  cartoonsModel: cartoonPlaylist[index],
                                )));
                      },
                      child: Card(
                        elevation: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: SizedBox(
                            height: 180,
                            width: 150,
                            child: Image.network(
                              cartoonPlaylist[index].img,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ));
                }),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
