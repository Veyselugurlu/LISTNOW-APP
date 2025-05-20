import 'custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import '../constant/product_colors.dart';
import '../extension/lottie_extension.dart';

class CustomDialogs {
  static final dialogDurationMS = 1250;

  static showLoadingDialog({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => Dialog(
            backgroundColor: ProductColors.instance.white.withValues(
              alpha: 0.15,
            ),
            elevation: 0,
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            child: SizedBox(
              width: context.sized.dynamicWidth(1),
              height: context.sized.dynamicHeight(1),
              child: Center(
                child: Container(
                  width: context.sized.dynamicWidth(0.6),
                  height: context.sized.dynamicWidth(0.6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ProductColors.instance.white,
                  ),
                  child: Center(
                    child: Lottie.asset(
                      Lotties.loading_lottie.getPath,
                      width: context.sized.dynamicWidth(0.8),
                      height: context.sized.dynamicHeight(0.4),
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
  }

  static showSuccessDialog({
    required BuildContext context,
    required String message,
    bool isSecondCloseActive = false,
  }) {
    Future.delayed(Duration(milliseconds: dialogDurationMS), () {
      if (context.mounted) {
        Navigator.pop(context);

        if (isSecondCloseActive) {
          Navigator.pop(context);
        }
      }
    });
    AlertDialog successDialog = AlertDialog(
      elevation: 10,
      contentPadding: EdgeInsets.zero,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ProductColors.instance.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ProductColors.instance.emeraldGreen,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Lottie.asset(
                Lotties.success.getPath,
                width: context.sized.dynamicWidth(0.4),
                height: context.sized.dynamicHeight(0.2),
                repeat: false,
              ),
            ),
            CustomSizedBox.getSmall0005Seperator(context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: context.general.textTheme.titleMedium,
                  ).animate().slideY(begin: 1).fade(),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => successDialog,
    );
  }

  static showErrorDialog({
    required BuildContext context,
    required String message,
  }) {
    Future.delayed(Duration(milliseconds: dialogDurationMS), () {
      if (context.mounted) {
        Navigator.pop(context);
      }
    });

    AlertDialog errorDialog = AlertDialog(
      elevation: 10,
      contentPadding: EdgeInsets.zero,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ProductColors.instance.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ProductColors.instance.firebrickRed,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Lottie.asset(
                Lotties.error.getPath,
                width: context.sized.dynamicWidth(0.4),
                height: context.sized.dynamicHeight(0.2),
                repeat: false,
              ),
            ),
            CustomSizedBox.getSmall0005Seperator(context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: context.general.textTheme.titleMedium,
                  ).animate().slideY(begin: 1).fade(),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => errorDialog,
    );
  }

  static showErrorDialogAndNavigate({
    required BuildContext context,
    required String message,
    required String route,
  }) {
    Future.delayed(Duration(milliseconds: dialogDurationMS), () {
      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(context, route, (_) => false);
      }
    });

    AlertDialog errorDialog = AlertDialog(
      elevation: 10,
      contentPadding: EdgeInsets.zero,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ProductColors.instance.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ProductColors.instance.firebrickRed,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Lottie.asset(
                Lotties.error.getPath,
                width: context.sized.dynamicWidth(0.4),
                height: context.sized.dynamicHeight(0.2),
                repeat: false,
              ),
            ),
            CustomSizedBox.getSmall0005Seperator(context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: context.general.textTheme.titleMedium,
                  ).animate().slideY(begin: 1).fade(),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => errorDialog,
    );
  }

  static showWarningDialog({
    required BuildContext context,
    required String message,
    required VoidCallback onConfirm, // Devam Et butonu için callback
  }) {
    AlertDialog warningDialog = AlertDialog(
      elevation: 10,
      contentPadding: EdgeInsets.zero,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ProductColors.instance.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Koyu sarı arka plan
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFFFD580),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Lottie.asset(
                Lotties.warning.getPath,
                width: context.sized.dynamicWidth(0.4),
                height: context.sized.dynamicHeight(0.2),
                repeat: false,
              ),
            ),
            CustomSizedBox.getSmall0005Seperator(context),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child:
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: context.general.textTheme.titleMedium,
                  ).animate().slideY(begin: 1).fade(),
            ),
            CustomSizedBox.getSmall0005Seperator(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context), // Dialog'u kapat
                  style: TextButton.styleFrom(
                    foregroundColor: ProductColors.instance.grey,
                  ),
                  child: Text("İptal"),
                ),
                FilledButton(
                  onPressed: onConfirm, // Devam Et butonu için callback
                  style: TextButton.styleFrom(
                    foregroundColor: ProductColors.instance.white,
                  ),
                  child: Row(
                    children: [Text("Devam Et"), Icon(Icons.arrow_forward_ios)],
                  ),
                ),
              ],
            ),
            CustomSizedBox.getSmall0005Seperator(context),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => warningDialog,
    );
  }
}
