import 'package:flutter/material.dart';
import '../shared/data/constants.dart';
import '../shared/styles/app_styles.dart';
import 'loading_indicator.dart';

class LoadingSecondaryButton extends StatelessWidget {
  final bool maxWidth;
  final Color color;

  LoadingSecondaryButton(
      {super.key,
        this.maxWidth = false,
        this.color = AppStyles.primaryColor});

  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
      minWidth: maxWidth ? double.maxFinite : double.minPositive,
      onPressed: null,
      elevation: 0,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(width: 1, color: color)),
      color: Colors.transparent,
      child: LoadingIndicator(os: getOs(), color: color,),
    );
  }
}
