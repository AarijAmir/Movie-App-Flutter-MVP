import 'package:flutter/material.dart';

Widget buildLoadingWidget(Size size) {
  return SizedBox(
    width: size.width * 0.1,
    height: size.width * 0.1,
    child: const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      strokeWidth: 1,
    ),
  );
}
