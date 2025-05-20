import 'package:barcode_scan2/model/scan_options.dart';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:bulut_bilisim_odev_uygulamasi/core/routes/routes.dart';
import '../../../core/cache/cache_manager.dart';
import '../../../core/model/item_model.dart';
import '../../../core/service/base_service.dart';
import '../../../product/constant/product_colors.dart';
import '../../../product/util/custom_dialogs.dart';
import '../../../product/util/custom_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:uuid/uuid.dart';

class ListProductsViewModel extends ChangeNotifier {
  IBaseService _service = BaseService();

  String scanResult = "";

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future<void> scan({required BuildContext context}) async {
    try {
      var options = const ScanOptions();

      var result = await BarcodeScanner.scan(options: options);
      scanResult = result.rawContent;
      notifyListeners();
    } on PlatformException catch (e) {
      if (context.mounted) {
        CustomDialogs.showErrorDialog(
          context: context,
          message: e.message ?? "Failed to Get Platform Version",
        );
      }
    }
  }

  Future<void> scanAndSearch({
    required BuildContext context,
    required String listId,
  }) async {
    try {
      var options = const ScanOptions();

      var result = await BarcodeScanner.scan(options: options);
      final resultBarcode = result.rawContent;

      if (resultBarcode.isNotEmpty) {
        ItemModel item = await _service.searchWBarcodeProduct(
          barcode: resultBarcode,
          listId: listId,
        );

        if (context.mounted) {
          Navigator.pushNamed(
            context,
            Routes.SEARCH_PRODUCT_RESULT,
            arguments: {"itemModel": item},
          );
        }
      }
    } on PlatformException catch (e) {
      if (context.mounted) {
        CustomDialogs.showErrorDialog(
          context: context,
          message: e.message ?? "Failed to Get Platform Version",
        );
      }
    }
  }

  Future<void> addProduct(BuildContext context, String listId) async {
    try {
      if (formKey.currentState!.validate()) {
        CustomDialogs.showLoadingDialog(context: context);

        String? username = await CacheManager.instance.getUsername();

        if (username != null) {
          var uuid = Uuid();
          String itemUuid = "$listId-${uuid.v4()}";

          ItemModel newItem = ItemModel(
            uuid: itemUuid,
            listId: listId,
            title: titleController.text,
            content: contentController.text,
            barcode: scanResult,
            owner: username,
            creationDate: Timestamp.now(),
          );

          await _service.addProduct(item: newItem);

          if (context.mounted) {
            clearFields();
            Navigator.pop(context);
            CustomDialogs.showSuccessDialog(
              context: context,
              message: "Ürün başarıyla eklendi.",
              isSecondCloseActive: true,
            );
          }
        } else {
          if (context.mounted) {
            Navigator.pop(context);
            clearFields();
            CustomDialogs.showErrorDialog(
              context: context,
              message: "Bir hata meydana geldi",
            );
          }
        }
      }
    } on CustomException catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        clearFields();
        CustomDialogs.showErrorDialog(
          context: context,
          message: e.message ?? "Bir hata meydana geldi",
        );
      }
    }
  }

  Future<void> deleteProduct(BuildContext context, String itemId) async {
    bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Ürünü Sil"),
          content: const Text("Bu ürünü silmek istediğinize emin misiniz?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                "Evet",
                style: context.general.textTheme.bodyMedium!.copyWith(
                  color: ProductColors.instance.grey700,
                ),
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "İptal",
                style: context.general.textTheme.bodyMedium!.copyWith(
                  color: ProductColors.instance.white,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      try {
        if (context.mounted) CustomDialogs.showLoadingDialog(context: context);

        await _service.deleteProduct(itemId: itemId);

        if (context.mounted) {
          Navigator.pop(context);
          CustomDialogs.showSuccessDialog(
            context: context,
            message: "Ürün başarıyla silindi.",
          );
        }
      } on CustomException catch (e) {
        if (context.mounted) {
          Navigator.pop(context);
          CustomDialogs.showErrorDialog(context: context, message: e.message);
        }
      }
    }
  }

  void updateProductInit(ItemModel itemModel) {
    titleController.text = itemModel.title ?? "";
    contentController.text = itemModel.content ?? "";
    scanResult = itemModel.barcode ?? "";
    notifyListeners();
  }

  Future<void> updateProduct(BuildContext context, ItemModel item) async {
    try {
      if (formKey.currentState!.validate()) {
        CustomDialogs.showLoadingDialog(context: context);

        ItemModel updateItem = ItemModel(
          uuid: item.uuid,
          listId: item.listId,
          title: titleController.text,
          content: contentController.text,
          barcode: scanResult,
          owner: item.owner,
          creationDate: item.creationDate,
        );

        await _service.updateProduct(item: updateItem);

        if (context.mounted) {
          Navigator.pop(context);
          clearFields();
          CustomDialogs.showSuccessDialog(
            context: context,
            message: "Ürün başarıyla güncellendi.",
            isSecondCloseActive: true,
          );
        }
      }
    } on CustomException catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        clearFields();
        CustomDialogs.showErrorDialog(
          context: context,
          message: e.message ?? "Bir hata meydana geldi",
        );
      }
    }
  }

  void clearFields() {
    titleController.clear();
    contentController.clear();
    scanResult = "";
    notifyListeners();
  }
}
