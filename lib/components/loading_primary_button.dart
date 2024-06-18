import 'package:flutter/material.dart';
import '../shared/data/constants.dart';
import '../shared/styles/app_styles.dart';
import 'loading_indicator.dart';

class LoadingPrimaryButton extends StatelessWidget {
  final bool maxWidth;
  final Color color;

  LoadingPrimaryButton(
      {super.key,
        this.maxWidth = false,
        this.color = AppStyles.primaryColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: maxWidth ? double.maxFinite : double.minPositive,
      onPressed: () {},
      elevation: 0,
      padding: EdgeInsets.symmetric(vertical: 11, horizontal: 18),
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      color: color,
      child: LoadingIndicator(os: getOs(), color: Colors.white,),
    );
  }
}
