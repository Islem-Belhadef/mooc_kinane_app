import 'package:klearn/shared/styles/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {

  final String os;
  final Color color;

  LoadingIndicator({super.key, required this.os, this.color = AppStyles.primaryColor});

  @override
  Widget build(BuildContext context) {
    if (this.os == 'android') return CircularProgressIndicator(color: color,);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: CupertinoActivityIndicator(),
    );
  }
}