import '../../../core/cache/cache_manager.dart';
import '../../../core/routes/routes.dart';
import '../../../core/service/base_service.dart';
import '../../../product/util/product_util.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final BaseService _baseService = BaseService();
  String? usernameErrorText;

  Future<void> registerUser(BuildContext context) async {
    await checkUsernameUniqueness();

    if (!formKey.currentState!.validate()) return;

    final username = usernameController.text.trim();
    final rawPassword = passwordController.text;
    final hashedPassword = ProductUtil.hashPassword(rawPassword);

    final result = await _baseService.register(username, hashedPassword);

    if (context.mounted) {
      if (result) {
        CacheManager.instance.saveUsername(username: usernameController.text);
        clearFields();
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.NAVIGATION,
          (_) => false,
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Kayıt başarılı")));
      } else {
        clearFields();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Kayıt başarısız")));
      }
    }
  }

  Future<void> checkUsernameUniqueness() async {
    final username = usernameController.text.trim();

    final exists = await _baseService.checkUsernameExists(username);

    if (exists) {
      usernameErrorText = "Bu kullanıcı adı zaten alınmış.";
    } else {
      usernameErrorText = null;
    }

    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    passwordController2.dispose();
    super.dispose();
  }

  void clearFields() {
    usernameController.clear();
    passwordController.clear();
    passwordController2.clear();
    notifyListeners();
  }
}
