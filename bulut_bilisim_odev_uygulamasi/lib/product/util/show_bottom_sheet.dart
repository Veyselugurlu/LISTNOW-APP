import '../constant/product_colors.dart';
import 'package:flutter/material.dart';

mixin ShowBottomSheet {
  Future<T?> showCustomSheet<T>(BuildContext context, Widget widget) async {
    return showModalBottomSheet<T>(
      backgroundColor: ProductColors.instance.white,
      elevation: 0,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return widget;
      },
    );
  }
}
