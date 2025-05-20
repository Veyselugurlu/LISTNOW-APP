import 'package:flutter/material.dart';

class ProductColors {
  static ProductColors? _instance;
  static ProductColors get instance {
    _instance ??= ProductColors._init();
    return _instance!;
  }

  ProductColors._init();

  Color black = Colors.black;
  Color white = Colors.white;

  Color firefly = Color(0xFF023336);
  Color algae = Color(0xFF4DA674);
  Color lightsage = Color(0xFFC1E6BA);
  Color offgreen = Color(0xFFEAF8E7);

  Color green1 = Color(0xFF2C98A0);
  Color green2 = Color(0xFF38B2A3);
  Color green3 = Color(0xFF4CC8A3);
  Color green4 = Color(0xFF67DBA5);
  Color green5 = Color(0xFF89EBAC);
  Color green6 = Color(0xFFB0F2BC);

  Color grey = Colors.grey;
  Color grey100 = Colors.grey[100]!;
  Color grey200 = Colors.grey[200]!;
  Color grey300 = Colors.grey[300]!;
  Color grey350 = Colors.grey[350]!;
  Color grey400 = Colors.grey[400]!;
  Color grey600 = Colors.grey[600]!;
  Color grey700 = Colors.grey[700]!;

  Color successGreen = const Color(0xff5CB85C);
  Color darkGreen = const Color(0xFF006400);
  Color emeraldGreen = Color(0xFF009C4E);

  Color errorRed = const Color(0xffD9534F);
  Color darkRed = const Color(0xffB33C34);
  Color firebrickRed = const Color(0xffB22222);

  Color electricBlue = const Color(0xFF0066FF);
}
