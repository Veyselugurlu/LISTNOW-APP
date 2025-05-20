import 'package:flutter/material.dart';

import '../../product/constant/product_border_radius.dart';
import '../../product/constant/product_colors.dart';

class CustomTheme {
  static CustomTheme? _instance;
  static CustomTheme get instance {
    _instance ??= CustomTheme._init();
    return _instance!;
  }

  CustomTheme._init();

  ThemeData get apptheme => _theme;

  final ThemeData _theme = ThemeData(
    scaffoldBackgroundColor: ProductColors.instance.offgreen,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
    colorScheme: ColorScheme.fromSeed(seedColor: ProductColors.instance.algae),
    useMaterial3: true,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ProductColors.instance.algae,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: ProductBorderRadius.circularLow(),
        ),
        backgroundColor: ProductColors.instance.algae,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ProductColors.instance.algae,
        backgroundColor: ProductColors.instance.white,
        side: BorderSide(color: ProductColors.instance.algae, width: 1.5),
      ),
    ),
  );
}
