import 'package:flutter/material.dart';
import '../shared/styles/app_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function()? fun;
  final bool maxWidth;
  final String? data;
  final Color textColor;
  final Color color;

  PrimaryButton(
      {super.key,
      required this.title,
      this.fun,
      this.maxWidth = false,
      this.data,
      this.textColor = Colors.white,
      this.color = AppStyles.primaryColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: maxWidth ? double.maxFinite : double.minPositive,
      onPressed: fun,
      elevation: 0,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      color: color,
      child: Text(title,
          style: AppStyles.regularTextStyle(
              fontSize: 16, weight: FontWeight.w600, color: textColor)),
    );
  }
}
