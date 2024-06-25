import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klearn/screens/downloaded_course.dart';
import 'package:klearn/shared/data/constants.dart';
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

        return FutureBuilder(
          future: cubit.getDownloadedVideos(),
          builder: (context, snapshot) => SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Téléchargements',
                    style: AppStyles.headingTextStyle(),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ConditionalBuilder(
                    condition: cubit.downloadedCourses.isNotEmpty,
                    builder: (context) => ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                cubit.downloadedCourse =
                                    cubit.downloadedCourses[index];
                                navigateTo(
                                    context,
                                    DownloadedCourseScreen(
                                      courseId:
                                          cubit.downloadedCourses[index].id!,
                                    ));
                              },
                              child: Card(
                                color: Colors.blue[50],
                                elevation: 5,
                                shadowColor: Colors.grey.withOpacity(0.3),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 8),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        'https://instructor-academy.onlinecoursehost.com/content/images/2023/05/How-to-Create-an-Online-Course-For-Free--Complete-Guide--6.jpg',
                                        width: 100,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 14,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cubit.downloadedCourses[index]
                                                  .title!,
                                              style: AppStyles.headingTextStyle(
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              cubit.downloadedCourses[index]
                                                  .description!,
                                              style:
                                                  AppStyles.regularTextStyle(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
