// ignore: constant_identifier_names
enum Lotties { loading_lottie, success, error, warning }

extension LottieExtension on Lotties {
  String get getPath => "assets/lotties/$name.json";
}
