import 'package:base_app/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);


  // HomeLayout navigation
  int currentIndex = 0;

  List screens = [HomeScreen()];

  void changeBNB(int index) {
    currentIndex = index;
    emit(ChangeScreenAppState());
  }
}