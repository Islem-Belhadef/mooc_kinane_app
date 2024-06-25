import 'package:klearn/shared/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../shared/state/app_cubit.dart';
import '../shared/state/app_states.dart';
import '../shared/styles/app_styles.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              // backgroundColor: Color(0xFFFED842),
              title: Text(
                app_name,
                style: AppStyles.headingTextStyle(),
              ),
              centerTitle: true,
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: Container(
              height: 76,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                selectedLabelStyle: AppStyles.regularTextStyle(
                    weight: FontWeight.w600,
                    fontSize: 12,
                    color: AppStyles.primaryColor),
                selectedItemColor: AppStyles.primaryColor,
                showUnselectedLabels: false,
                currentIndex: cubit.currentIndex,
                selectedIconTheme: IconThemeData(size: 30),
                onTap: (value) {
                  cubit.changeBNB(value);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.home_2),
                    label: 'Acceuil',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.book_saved),
                    label: 'Mes cours',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.import),
                    label: 'Téléchargements',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.user),
                    label: 'Profil',
                  ),
                ],
              ),
            ));
      },
      listener: (context, state) {},
    );
  }
}
