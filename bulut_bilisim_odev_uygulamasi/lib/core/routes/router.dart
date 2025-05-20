import 'package:bulut_bilisim_odev_uygulamasi/features/home/view/follow_notifications_view.dart';
import 'package:bulut_bilisim_odev_uygulamasi/features/list_products/view/search_product_result_view.dart';

import '../../color_containers.dart';
import 'routes.dart';
import '../../features/all_list/view/all_list_view.dart';
import '../../features/home/view/home_view.dart';
import '../../features/home/view/list_update_view.dart';
import '../../features/list_products/view/list_product_add_view.dart';
import '../../features/list_products/view/list_product_update_view.dart';
import '../../features/list_products/view/list_products_view.dart';
import '../../features/login/view/login_view.dart';
import '../../features/navigation/view/navigation_view.dart';
import '../../features/register/view/register_view.dart';
import '../../features/splash/view/splash_view.dart';
import '../../features/home/view/user_list_add_view.dart';
import 'package:flutter/material.dart';

class CRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    Curve animationCurve = Curves.easeInOut;
    Offset beginOffset = const Offset(1, 0);

    //**
    // Offset(1, 0) --> Sağdan Sola
    // Offset(0, 1) --> Aşağıdan Yukarıya
    // */

    switch (settings.name) {
      case Routes.COLOR_CONTAINER:
        page = const ColorContainers();
        beginOffset = const Offset(0, 1);
        break;

      case Routes.SPLASH:
        page = const SplashView();
        beginOffset = const Offset(0, 1);
        break;

      case Routes.LOGIN:
        page = const LoginView();
        break;

      case Routes.REGISTER:
        page = const RegisterView();
        break;

      case Routes.NAVIGATION:
        page = const NavigationView();
        break;

      case Routes.HOME:
        page = const HomeView();
        break;

      case Routes.USER_LIST_ADD:
        page = const ListAddView();
        beginOffset = Offset(0, 1);
        break;

      case Routes.USER_LIST_UPDATE:
        final args = settings.arguments as Map<String, dynamic>;

        page = ListUpdateView(listModel: args['listModel']);
        beginOffset = Offset(0, 1);
        break;

      case Routes.LIST_PRODUCTS:
        final args = settings.arguments as Map<String, dynamic>;
        page = ListProductsView(
          listId: args['listId'],
          listName: args['listName'],
        );
        break;

      case Routes.LIST_PRODUCT_ADD:
        final args = settings.arguments as Map<String, dynamic>;

        page = ListProductAddView(listId: args['listId']);
        beginOffset = Offset(0, 1);
        break;

      case Routes.LIST_PRODUCT_UPDATE:
        final args = settings.arguments as Map<String, dynamic>;

        page = ListProductUpdateView(itemModel: args['itemModel']);
        beginOffset = Offset(0, 1);
        break;

      case Routes.ALL_LIST:
        page = const AllListView();
        beginOffset = Offset(0, 1);
        break;

      case Routes.FOLLOW_NOTIFICATIONS:
        final args = settings.arguments as Map<String, dynamic>;

        page = FollowNotificationsView(currentUsername: args["username"]);
        break;

      case Routes.SEARCH_PRODUCT_RESULT:
        final args = settings.arguments as Map<String, dynamic>;

        page = SearchProductResultView(itemModel: args["itemModel"]);
        beginOffset = Offset(0, 1);
        break;

      default:
        page = const SplashView();
    }

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: beginOffset,
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: animationCurve)),
          child: child,
        );
      },
    );
  }
}
