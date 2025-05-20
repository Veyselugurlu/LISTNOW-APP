import '../../../core/routes/routes.dart';
import '../validator/register_validator.dart';
import '../viewModel/register_view_model.dart';
import '../../../product/constant/product_border_radius.dart';
import '../../../product/constant/product_colors.dart';
import '../../../product/constant/product_padding.dart';
import '../../../product/util/custom_dialogs.dart';
import '../../../product/util/custom_sized_box.dart';
import '../../../product/widget/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: ProductColors.instance.offgreen,
      body: _buildLogo(),
    );
  }

  Widget _buildLogo() {
    return Consumer<RegisterViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding: EdgeInsets.only(top: context.sized.dynamicHeight(0.1)),

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: context.sized.dynamicHeight(0.2),
                  child: Image.asset(
                    'assets/images/image.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(child: _builBody(viewModel)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _builBody(RegisterViewModel viewModel) {
    return Padding(
      padding: ProductPadding.allHigh(),
      child: Center(
        child: Consumer<RegisterViewModel>(
          builder: (context, viewmodel, child) {
            return Container(
              width: context.sized.dynamicWidth(1),
              height: context.sized.dynamicHeight(0.44),
              padding: ProductPadding.allLow(),
              decoration: BoxDecoration(
                color: ProductColors.instance.green6.withValues(alpha: 0.6),
                borderRadius: ProductBorderRadius.circularHigh(),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomSizedBox.getSmall015Seperator(context),

                      CustomTextField(
                        controller: viewModel.usernameController,
                        hintText: "Kullanıcı Adı",
                        prefixIcon: Icons.supervised_user_circle_sharp,
                        isObscure: false,
                        validator: (value) {
                          final basicValidation =
                              RegisterValidators.validateUsername(value);
                          if (basicValidation != null) return basicValidation;
                          return viewModel.usernameErrorText;
                        },
                      ),
                      CustomSizedBox.getSmall025Seperator(context),
                      CustomTextField(
                        controller: viewModel.passwordController,
                        hintText: "Şifre",
                        prefixIcon: Icons.lock,
                        isObscure: true,
                        validator: (value) {
                          return RegisterValidators.validatePasswordConfirm(
                            value,
                            viewModel.passwordController.text,
                          );
                        },
                      ),
                      CustomSizedBox.getSmall025Seperator(context),
                      CustomTextField(
                        controller: viewModel.passwordController2,
                        hintText: "Şifre (Tekrar)",
                        prefixIcon: Icons.lock,
                        isObscure: true,
                        validator: (value) {
                          return RegisterValidators.validatePasswordConfirm(
                            value,
                            viewModel.passwordController.text,
                          );
                        },
                      ),
                      CustomSizedBox.getSmall015Seperator(context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Bir hesabınız var mı ?",
                            style: context.general.textTheme.bodyMedium!
                                .copyWith(
                                  color: ProductColors.instance.grey700,
                                ),
                          ),
                          TextButton(
                            onPressed: () {
                              CustomDialogs.showLoadingDialog(context: context);
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.LOGIN,
                                (route) => false,
                              );
                            },
                            child: Text(
                              "Giriş Yap!",
                              style: context.general.textTheme.titleMedium!
                                  .copyWith(
                                    color: ProductColors.instance.algae,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          fixedSize: Size(
                            context.sized.dynamicWidth(0.75),
                            context.sized.dynamicHeight(0.0075),
                          ),
                        ),
                        onPressed: () {
                          viewModel.registerUser(context);
                        },
                        child: Text("Kaydol"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
