import 'package:flutter/material.dart';
import '../shared/styles/app_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final bool hidden;
  final bool suffix;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final validate;
  final cubit;
  final bool readOnly;

  PrimaryButton({
    super.key,
    required this.title,
    this.hidden = false,
    this.suffix = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.validate,
    this.cubit,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      cursorColor: AppStyles.primaryColor,
      keyboardType: keyboardType,
      style: AppStyles.regularTextStyle(fontSize: 16),
      obscureText: hidden,
      controller: controller,
      validator: validate,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: AppStyles.regularTextStyle(),
        focusColor: AppStyles.primaryColor,
        suffixIcon: suffix
            ? IconButton(
                icon: Icon(cubit.suffix),
                onPressed: () {
                  cubit.changeObscurity();
                },
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: AppStyles.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0XFFEEEEEE)),
        ),
      ),
    );
  }
}
