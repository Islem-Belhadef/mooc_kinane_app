import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:klearn/screens/downloaded_course.dart';
import 'package:klearn/screens/downloads.dart';
import 'package:klearn/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klearn/shared/data/cache_helper.dart';
import 'package:klearn/shared/data/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/course.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  // HomeLayout navigation
  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    HomeScreen(),
    DownloadsScreen(),
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

  Database? database;

  void createDatabase() async {
    var database = await openDatabase('klearn.db', version: 1,
        onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE courses (id INTEGER PRIMARY, title TEXT, description TEXT, video_path TEXT, watch_time TEXT, status INTEGER)')
          .then((value) => print('Courses table created successfully'))
          .catchError((error) =>
              print('Error when creating courses table ${error.toString()}'));
    }, onOpen: (database) {
      print('Database opened');
    });
  }

  void insertCourseToDB({
    required String title,
    required String description,
    required String videoPath,
  }) {
    database!.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO courses (title, description, video_path, watch_time, status) VALUES(?, ?, ?, "00:00", 0)',
              [
                title,
                description,
                videoPath
              ])
          .then((value) => print('inserted successfully'))
          .catchError((error) =>
              print('error while inserting into database ${error.toString()}'));
    });
  }

  List<CourseModel> downloadedCourses = [];
  CourseModel? downloadedCourse;

  void getDownloadedVideos() async {
    downloadedCourses = [];
    List<Map<String, dynamic>> courses =
        await database!.rawQuery('SELECT * FROM courses');
    courses.forEach((course) {
      downloadedCourses.add(CourseModel.fromJson(course));
    });
  }

  List<String>? downloads = CacheHelper.getListData(key: 'downloads')!;
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
      CacheHelper.setData(key: 'video_path', value: savePath);
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
      downloads != null
          ? downloads!.add(videoFilePath)
          : downloads = [videoFilePath];
      CacheHelper.setData(key: 'downloads', value: downloads);
      insertCourseToDB(
          title: 'course 1',
          description: "Course 1 description",
          videoPath: videoFilePath);
      navigateTo(context, DownloadedCourseScreen());
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
