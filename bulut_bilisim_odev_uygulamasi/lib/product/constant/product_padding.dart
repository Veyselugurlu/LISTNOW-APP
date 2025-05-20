import 'package:flutter/material.dart';

class ProductPadding extends EdgeInsets {
  //All
  const ProductPadding.allLow25() : super.all(2.5);
  const ProductPadding.allLow5() : super.all(5);
  const ProductPadding.allLow() : super.all(10);
  const ProductPadding.allMedium() : super.all(15);
  const ProductPadding.allHigh() : super.all(20);

  //Symmetric
  const ProductPadding.horizontalLow5() : super.symmetric(horizontal: 5);
  const ProductPadding.horizontalLow() : super.symmetric(horizontal: 10);
  const ProductPadding.horizontalMedium() : super.symmetric(horizontal: 15);
  const ProductPadding.horizontalHigh() : super.symmetric(horizontal: 20);

  const ProductPadding.verticalLow() : super.symmetric(vertical: 10);
  const ProductPadding.verticalMedium() : super.symmetric(vertical: 15);
  const ProductPadding.verticalHigh() : super.symmetric(vertical: 20);

  const ProductPadding.v20h12() : super.symmetric(vertical: 20, horizontal: 12);

  //Only
  const ProductPadding.onlyRightLow5() : super.only(right: 5);
  const ProductPadding.onlyRightLow() : super.only(right: 10);
  const ProductPadding.onlyRightMedium() : super.only(right: 15);
  const ProductPadding.onlyRightHigh() : super.only(right: 20);

  const ProductPadding.onlyl20t15() : super.only(left: 20, top: 15);
  const ProductPadding.onlyl15t15b10()
    : super.only(left: 15, top: 15, bottom: 10);
  const ProductPadding.onlyl15r15b20()
    : super.only(left: 15, right: 15, bottom: 20);
  const ProductPadding.onlyl15r15b10()
    : super.only(left: 15, right: 15, bottom: 10);

  //Bottom
  const ProductPadding.bottomLow() : super.only(bottom: 10);
  const ProductPadding.bottomMedium() : super.only(bottom: 15);
  const ProductPadding.bottomHigh() : super.only(bottom: 20);

  //Top
  const ProductPadding.topLow() : super.only(top: 10);
  const ProductPadding.topMedium() : super.only(top: 15);
  const ProductPadding.topHigh() : super.only(top: 20);
}
