import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klearn/components/primary_button.dart';
import 'package:klearn/shared/state/app_cubit.dart';
import 'package:klearn/shared/state/app_states.dart';
import 'package:video_player/video_player.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late VideoPlayerController _controller;
  late FlickManager flickManager;
  String _url = 'https://media.istockphoto.com/id/1346773711/video/drone-shot-of-a-young-mother-with-her-young-son-in-a-carrier-hiking-on-a-mountain-trail-at.mp4?s=mp4-640x640-is&k=20&c=O7g6vhbFy5cRooH3DvBQevzToVVn0CVoO10ortFY5QU=';

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(_url),
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

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: FlickVideoPlayer(flickManager: flickManager)),
                PrimaryButton(
                  title: 'Télécharger',
                  fun: () {
                    cubit.downloadVideo(_url, context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
