import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klearn/components/primary_button.dart';
import 'package:klearn/shared/data/cache_helper.dart';
import 'package:klearn/shared/state/app_cubit.dart';
import 'package:klearn/shared/state/app_states.dart';
import 'package:video_player/video_player.dart';

class DownloadedCourseScreen extends StatefulWidget {
  const DownloadedCourseScreen({super.key});

  @override
  State<DownloadedCourseScreen> createState() => _DownloadedCourseScreenState();
}

class _DownloadedCourseScreenState extends State<DownloadedCourseScreen> {
  late VideoPlayerController _controller;
  late FlickManager flickManager;
  String filePath = CacheHelper.getData(key: 'video_path');

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(filePath),
        videoPlayerOptions: VideoPlayerOptions(
          allowBackgroundPlayback: false,
        ));
    flickManager = FlickManager(videoPlayerController: _controller);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(false);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(

      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        String _url = cubit.videoFilePath;
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: FlickVideoPlayer(flickManager: flickManager)),
              ],
            ),
          ),
        );
      },
    );
  }
}
