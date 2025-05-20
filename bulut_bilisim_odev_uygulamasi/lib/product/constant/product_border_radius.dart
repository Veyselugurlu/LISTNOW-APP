import 'package:flutter/material.dart';

class ProductBorderRadius extends BorderRadius {
  //Circular
  ProductBorderRadius.circularLow() : super.circular(10);
  ProductBorderRadius.circularMedium() : super.circular(15);
  ProductBorderRadius.circularHigh() : super.circular(20);
  ProductBorderRadius.circularHigh30() : super.circular(30);

  //Only
  const ProductBorderRadius.circularOnly20BRBL()
    : super.only(
        bottomRight: const Radius.circular(20),
        bottomLeft: const Radius.circular(20),
      );
  const ProductBorderRadius.circularOnly15BRBL()
    : super.only(
        bottomRight: const Radius.circular(15),
        bottomLeft: const Radius.circular(15),
      );
  const ProductBorderRadius.circularOnly15TRTL()
    : super.only(
        topRight: const Radius.circular(15),
        topLeft: const Radius.circular(15),
      );
}
