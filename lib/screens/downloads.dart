import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klearn/shared/state/app_cubit.dart';
import 'package:klearn/shared/state/app_states.dart';
import 'package:klearn/shared/styles/app_styles.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
            child: Column(
              children: [
                Text(
                  'Téléchargements',
                  style: AppStyles.headingTextStyle(),
                ),
                ConditionalBuilder(
                  condition: cubit.downloadedCourses.isNotEmpty,
                  builder: (context) => ListView.separated(
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {},
                            child: Container(
                              child: Column(
                                children: [
                                  Text(
                                    cubit.downloadedCourses[index].title!,
                                    style: AppStyles.headingTextStyle(
                                        fontSize: 20),
                                  ),
                                  Text(
                                    cubit.downloadedCourses[index].description!,
                                    style: AppStyles.regularTextStyle(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: cubit.downloadedCourses.length),
                  fallback: (context) => Text(
                    'Aucun cours téléchargé',
                    style: AppStyles.regularTextStyle(),
                  ),
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
