import 'package:flutter/material.dart';

Widget buildErrorWidget(String error) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Error Occurred Caught: $error",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
