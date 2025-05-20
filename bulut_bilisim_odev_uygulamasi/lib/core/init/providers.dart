import '../service/snapshot_manager.dart';
import '../../features/all_list/viewmodel/all_list_view_model.dart';
import '../../features/home/viewModel/home_view_model.dart';
import '../../features/list_products/viewModel/list_products_view_model.dart';
import '../../features/login/viewModel/login_view_model.dart';
import '../../features/navigation/viewModel/navigation_view_model.dart';
import '../../features/register/viewModel/register_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../features/splash/viewModel/splash_view_model.dart';

class Providers {
  static List<SingleChildWidget> getProviders = [
    ChangeNotifierProvider(create: (context) => SplashViewModel()),
    ChangeNotifierProvider(create: (context) => LoginViewModel()),
    ChangeNotifierProvider(create: (context) => RegisterViewModel()),
    ChangeNotifierProvider(create: (context) => NavigationViewModel()),
    ChangeNotifierProvider(create: (context) => HomeViewModel()),
    ChangeNotifierProvider(create: (context) => SnapshotManager()),
    ChangeNotifierProvider(create: (context) => ListProductsViewModel()),
    ChangeNotifierProvider(create: (context) => AllListViewModel()),
  ];
}
