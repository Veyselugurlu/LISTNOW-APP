import '../../all_list/view/all_list_view.dart';
import '../../home/view/home_view.dart';
import 'package:flutter/material.dart';

class NavigationViewModel extends ChangeNotifier {
  List<Widget> pages = [const HomeView(), const AllListView()];

  int currentIndex = 0;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
