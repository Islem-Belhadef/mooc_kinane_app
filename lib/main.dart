import 'package:base_app/screens/home.dart';
import 'package:base_app/shared/data/cache_helper.dart';
import 'package:base_app/shared/data/constants.dart';
import 'package:base_app/shared/data/dio_helper.dart';
import 'package:base_app/shared/state/app_cubit.dart';
import 'package:base_app/shared/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await CacheHelper.init();
  await DioHelper.init();

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
          home: HomeScreen(),
        ));
  }
}
