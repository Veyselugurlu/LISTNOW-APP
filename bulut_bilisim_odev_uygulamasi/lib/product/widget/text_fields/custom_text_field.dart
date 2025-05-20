import '../../constant/product_border_radius.dart';
import '../../constant/product_colors.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isObscure,
    this.prefixIcon,
    this.lineNumber = 1,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final bool isObscure;
  final int lineNumber;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: ProductBorderRadius.circularHigh30(),
      borderSide: BorderSide(
        color: ProductColors.instance.firefly,
        width: 1.25,
      ),
    );

    return TextFormField(
      validator: validator,
      maxLines: lineNumber,
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: context.general.textTheme.bodyMedium!.copyWith(
          color: ProductColors.instance.firefly.withValues(alpha: 0.75),
        ),
        fillColor: ProductColors.instance.green6,
        filled: true,
        prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
        prefixIconColor: ProductColors.instance.firefly.withValues(alpha: 0.75),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: border,
        disabledBorder: border,
      ),
    );
  }
}
