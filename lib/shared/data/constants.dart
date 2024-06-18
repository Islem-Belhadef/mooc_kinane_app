import 'dart:io';

import 'package:flutter/material.dart';

final base_url = 'http://127.0.0.1:8000/api';

final app_name = 'App Name';

String getOs() {
  return Platform.operatingSystem;
}

void navigateTo(BuildContext context, Widget widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateToAndFinish(BuildContext context, Widget widget) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (Route<dynamic> route) => false,
    );