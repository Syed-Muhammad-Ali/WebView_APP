// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    required this.child,
    required this.width,
    required this.height,
    required this.isShadow,
  });
  final Widget child;
  final double width;
  final double height;
  final bool isShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(kBorderRadius),

        color: Colors.white,

        boxShadow: [
          isShadow
              ? const BoxShadow(color: Colors.black26, blurRadius: 10)
              : const BoxShadow(color: Colors.black26, blurRadius: 10),
        ],
        border: Border.all(
          color: isShadow ? Colors.white : Colors.white,
          width: 3,
        ),
      ),
      child: child,
    );
  }
}
