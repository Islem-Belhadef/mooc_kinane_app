import 'package:klearn/screens/register.dart';
import 'package:klearn/shared/data/cache_helper.dart';
import 'package:klearn/shared/data/constants.dart';
import 'package:klearn/shared/data/dio_helper.dart';
import 'package:klearn/shared/state/app_cubit.dart';
import 'package:klearn/shared/styles/app_styles.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await CacheHelper.init();
  await DioHelper.init();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => AppCubit())],
        // supportedLocales: L10n.all,
        // locale: Locale(CacheHelper.getData(key: 'lang')),
        // localizationsDelegates: [
        //   AppLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        child: MaterialApp(
          title: app_name,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppStyles.primaryColor),
            useMaterial3: true,
          ),
          home: RegisterScreen(),
        ));
  }
}
