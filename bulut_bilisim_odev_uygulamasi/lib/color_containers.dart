import 'product/constant/product_colors.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ColorContainers extends StatelessWidget {
  const ColorContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: context.sized.dynamicWidth(1),
              height: context.sized.dynamicHeight(0.1),
              color: ProductColors.instance.firefly,
            ),
            Container(
              width: context.sized.dynamicWidth(1),
              height: context.sized.dynamicHeight(0.1),
              color: ProductColors.instance.algae,
            ),
            Container(
              width: context.sized.dynamicWidth(1),
              height: context.sized.dynamicHeight(0.1),
              color: ProductColors.instance.lightsage,
            ),
            Container(
              width: context.sized.dynamicWidth(1),
              height: context.sized.dynamicHeight(0.1),
              color: ProductColors.instance.offgreen,
            ),
            FilledButton(onPressed: () {}, child: Text("Filled")),
            OutlinedButton(onPressed: () {}, child: Text("Filled")),
            TextButton(onPressed: () {}, child: Text("Filled")),
          ],
        ),
      ),
    );
  }
}
