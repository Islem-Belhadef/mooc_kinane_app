import 'package:iconsax/iconsax.dart';
import 'package:mooc_kinane/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  // HomeLayout navigation
  int currentIndex = 0;

  List<Widget> screens = [HomeScreen(), HomeScreen(), HomeScreen()];

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

  void login() {

  }

  void register() {

  }

  void registerGoogle() {

  }

  void registerFacebook() {

  }
}
