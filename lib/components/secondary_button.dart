import 'package:flutter/material.dart';
import '../shared/styles/app_styles.dart';

class SecondaryButton extends StatelessWidget {
  final String title;
  final Function()? fun;
  final bool maxWidth;
  final String? data;
  final Color textColor;
  final Color color;

  SecondaryButton(
      {super.key,
        required this.title,
        this.fun,
        this.maxWidth = false,
        this.data,
        this.textColor = AppStyles.primaryColor,
        this.color = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: maxWidth ? double.maxFinite : double.minPositive,
      onPressed: fun,
      elevation: 0,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(width: 1, color: textColor)),
      color: color,
      child: Text(title,
          style: AppStyles.regularTextStyle(
              fontSize: 16, weight: FontWeight.w600, color: textColor)),
    );
  }
}
