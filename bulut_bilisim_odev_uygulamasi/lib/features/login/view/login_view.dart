import '../../../core/routes/routes.dart';
import '../viewModel/login_view_model.dart';
import '../../../product/constant/product_border_radius.dart';
import '../../../product/constant/product_colors.dart';
import '../../../product/constant/product_padding.dart';
import '../../../product/util/custom_sized_box.dart';
import '../../../product/widget/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: _buildBody());
  }

  Widget _buildBody() {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, _) {
        return Center(
          child: Padding(
            padding: ProductPadding.horizontalMedium(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "LISTNOW",
                  style: context.general.textTheme.displayLarge!.copyWith(
                    color: ProductColors.instance.firefly,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                CustomSizedBox.getMedium05Seperator(context),
                _buildLoginContainer(context, viewModel),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginContainer(BuildContext context, LoginViewModel viewModel) {
    return Container(
      padding: ProductPadding.allHigh(),
      width: context.sized.dynamicWidth(1),
      height: context.sized.dynamicHeight(0.336),
      decoration: BoxDecoration(
        borderRadius: ProductBorderRadius.circularHigh(),
        color: ProductColors.instance.green6.withValues(alpha: 0.5),
      ),
      child: Column(
        children: [
          CustomTextField(
            controller: viewModel.usernameController,
            hintText: "Kullanıcı Adı",
            prefixIcon: Icons.person,
            isObscure: false,
          ),
          CustomSizedBox.getSmall015Seperator(context),
          CustomTextField(
            controller: viewModel.passwordController,
            hintText: "Şifre",
            prefixIcon: Icons.lock,
            isObscure: true,
          ),
          CustomSizedBox.getSmall015Seperator(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Bir hesabınız yok mu ?",
                style: context.general.textTheme.bodyMedium!.copyWith(
                  color: ProductColors.instance.grey700,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.REGISTER);
                },
                child: Text(
                  "Kaydol!",
                  style: context.general.textTheme.titleMedium!.copyWith(
                    color: ProductColors.instance.algae,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          CustomSizedBox.getSmall015Seperator(context),
          FilledButton(
            style: FilledButton.styleFrom(
              fixedSize: Size(
                context.sized.dynamicWidth(0.75),
                context.sized.dynamicHeight(0.0075),
              ),
            ),
            onPressed: () {
              viewModel.login(context);
            },
            child: Text("Giriş Yap"),
          ),
        ],
      ),
    );
  }
}
