import '../../../core/cache/cache_manager.dart';
import '../../../core/routes/routes.dart';
import '../../../core/service/base_service.dart';
import '../../../product/util/custom_dialogs.dart';
import '../../../product/util/custom_exception.dart';
import 'package:flutter/widgets.dart';

class LoginViewModel extends ChangeNotifier {
  IBaseService _service = BaseService();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    try {
      CustomDialogs.showLoadingDialog(context: context);

      bool isLoginSuccess = await _service.login(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (context.mounted) {
        if (isLoginSuccess) {
          CacheManager.instance.saveUsername(
            username: usernameController.text.trim(),
          );
          Navigator.pop(context);
          clearFields();
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.NAVIGATION,
            (_) => false,
          );
        } else {
          Navigator.pop(context);
          clearFields();
          CustomDialogs.showErrorDialog(
            context: context,
            message: "Kullanıcı adı veya parola hatalı",
          );
        }
      }
    } on CustomException catch (e) {
      print(e.message);
    }
  }

  void clearFields() {
    usernameController.clear();
    passwordController.clear();
    notifyListeners();
  }
}
