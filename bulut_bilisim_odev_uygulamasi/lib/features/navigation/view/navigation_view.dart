import '../../home/view/user_list_add_view.dart';
import '../../../product/util/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../../product/constant/product_colors.dart';
import '../viewModel/navigation_view_model.dart';

class NavigationView extends StatelessWidget with ShowBottomSheet {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationViewModel>(
      builder: (context, viewModel, _) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: _buildFAB(context),
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: false,
            backgroundColor: ProductColors.instance.white,
            selectedItemColor: ProductColors.instance.algae,
            unselectedItemColor: ProductColors.instance.grey,
            iconSize: context.sized.dynamicWidth(0.07),
            currentIndex: viewModel.currentIndex,
            onTap: (value) => viewModel.changeCurrentIndex(value),
            items: const [
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: "Anasayfa",
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(Icons.public),
                icon: Icon(Icons.public_outlined),
                label: "Tüm Listeler",
              ),
            ],
          ),
          body: viewModel.pages[viewModel.currentIndex],
        );
      },
    );
  }

  FloatingActionButton _buildFAB(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        showCustomSheet(context, ListAddView());
      },
    );
  }
}
