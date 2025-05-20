import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum Logos { logos }

// ignore: constant_identifier_names
enum ImagePNGs { pngs }

// ignore: constant_identifier_names
enum ImageJPGs { jpgs }

extension LogosExtension on Logos {
  String get path => "assets/logo/$name.png";

  Image get image => Image.asset(path);
}

extension ImagePNGsExtension on ImagePNGs {
  String get path => "assets/images/$name.png";

  Image get image => Image.asset(path);
}

extension ImageJPGsExtension on ImageJPGs {
  String get path => "assets/images/$name.jpg";

  Image get image => Image.asset(path);
}
