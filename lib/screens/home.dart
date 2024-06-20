import 'package:carousel_slider/carousel_slider.dart';
import 'package:klearn/shared/state/app_cubit.dart';
import 'package:klearn/shared/state/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klearn/shared/styles/app_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 14.0),
                  child: Text(
                    'Nouveautés',
                    style: AppStyles.headingTextStyle(),
                  ),
                ),
                CarouselSlider(
                  items: cubit.carousel.map((carouselItem) {
                    return GestureDetector(
                      onTap: () {
                        //
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: carouselItem['color']
                        )
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 14.0, top: 20),
                  child: Text(
                    'Modules',
                    style: AppStyles.headingTextStyle(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
