import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klearn/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klearn/shared/data/dio_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  // HomeLayout navigation
  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen()
  ];

  void changeBNB(int index) {
    currentIndex = index;
    emit(ChangeScreenAppState());
  }

  IconData suffix = Iconsax.eye;
  bool isObscure = true;

  void changeObscurity() {
    isObscure = !isObscure;
    suffix = isObscure ? Iconsax.eye : Iconsax.eye_slash;
    emit(ChangePasswordVisibilityState());
  }

//   Register

  void login() {}

  void register() {}

  Future<UserCredential> registerGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // print(credential);
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<Future<UserCredential>> registerFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    print(facebookAuthCredential);
    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

//   carousels

  List<Map<String, dynamic>> carousel = [
    {'color': Colors.indigo},
    {'color': Colors.redAccent}
  ];

//    download course

  var downloadProgress;
  var videoFilePath;
  Dio dio = Dio();

  Future<void> downloadVideo(String url, BuildContext context) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String savePath = appDocDir.path + '/video.mp4';
      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = (received / total * 100);
            downloadProgress = progress;
            print(downloadProgress);
            emit(DownloadVideoState());
          }
        },
      );
      videoFilePath = savePath;
      print(videoFilePath);
      // Save the file path to Hive
      final box = await Hive.openBox<String>('videos');
      box.put('video_path', savePath);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(videoFilePath),
        ),
      );
      emit(DownloadVideoSuccessState());
    } catch (e) {
      print('Error downloading file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error downloading and saving video'),
        ),
      );
    }
  }
}
