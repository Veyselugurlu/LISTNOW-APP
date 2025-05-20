import '../../../core/cache/cache_manager.dart';
import '../../../core/model/item_model.dart';
import '../../../core/model/list_model.dart';
import '../../../core/routes/routes.dart';
import '../../../core/service/base_service.dart';
import '../../../product/constant/product_colors.dart';
import '../../../product/util/custom_dialogs.dart';
import '../../../product/util/custom_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:uuid/uuid.dart';

class HomeViewModel extends ChangeNotifier {
  IBaseService _service = BaseService();

  String? username;

  GlobalKey<FormState> updateFormKey = GlobalKey();
  TextEditingController titleController = TextEditingController();
  Map<String, bool> usernameAndState = {};
  List<String> newUsernameList = [];

  Future<void> init() async {
    await getUsername();
  }

  Future<void> getUsername() async {
    final usernameFromCache = await CacheManager.instance.getUsername();

    if (usernameFromCache != null) {
      username = usernameFromCache;
    }

    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    await CacheManager.instance.removeUsername();

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, Routes.LOGIN, (_) => false);
    }
  }

  Future<void> createList(BuildContext context) async {
    try {
      CustomDialogs.showLoadingDialog(context: context);

      var uuid = Uuid();
      String listUuid = uuid.v4();

      String? currentUser = await CacheManager.instance.getUsername();

      if (currentUser != null) {
        ListModel newList = ListModel(
          uuid: listUuid,
          title: titleController.text,
          creationDate: Timestamp.now(),
          ownerUsername: currentUser,
          usersOfList: [],
        );

        await _service.createList(list: newList);

        titleController.clear();

        if (context.mounted) {
          Navigator.pop(context);
          clearFields();
          CustomDialogs.showSuccessDialog(
            context: context,
            message: "Liste başarıyla oluşturuldu",
            isSecondCloseActive: true,
          );
        }
      }
    } on CustomException catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        clearFields();
        CustomDialogs.showErrorDialog(context: context, message: e.message);
      }
    }
  }

  Future<void> deleteList(BuildContext context, String listId) async {
    bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Listeyi Sil"),
          content: Text("Bu listeyi silmek istediğinize emin misiniz?"),
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

        await _service.deleteList(listId: listId);

        if (context.mounted) {
          Navigator.pop(context);
          CustomDialogs.showSuccessDialog(
            context: context,
            message: "Liste başarıyla silindi",
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

  void updateListInit(ListModel list) {
    titleController.text = list.title ?? "";
    usernameAndState = {
      for (var username in list.usersOfList ?? []) username: true,
    };
    newUsernameList = List<String>.from(list.usersOfList ?? []);
    notifyListeners();
  }

  void changeUsernameState(String username) {
    usernameAndState[username] = !(usernameAndState[username] ?? true);

    if (usernameAndState[username] == false) {
      newUsernameList.remove(username);
    } else {
      newUsernameList.add(username);
    }

    notifyListeners();
  }

  Future<void> updateList(BuildContext context, ListModel list) async {
    try {
      if (updateFormKey.currentState!.validate()) {
        CustomDialogs.showLoadingDialog(context: context);

        ListModel updateList = ListModel(
          uuid: list.uuid,
          title: titleController.text,
          ownerUsername: list.ownerUsername,
          creationDate: list.creationDate,
          usersOfList: newUsernameList,
        );

        await _service.updateList(list: updateList);

        if (context.mounted) {
          Navigator.pop(context);
          clearFields();
          CustomDialogs.showSuccessDialog(
            context: context,
            message: "Liste başarıyla güncellendi.",
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

  Future<void> acceptRequest({
    required BuildContext context,
    required String notificationId,
    required String listId,
    required String username,
  }) async {
    try {
      await _service.acceptRequest(
        notificationId: notificationId,
        listId: listId,
        username: username,
      );
    } on CustomException catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        CustomDialogs.showErrorDialog(
          context: context,
          message: e.message ?? "Bir hata meydana geldi",
        );
      }
    }
  }

  Future<void> declineRequest({
    required BuildContext context,
    required String notificationId,
  }) async {
    try {
      await _service.declineRequest(notificationId: notificationId);
    } on CustomException catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        CustomDialogs.showErrorDialog(
          context: context,
          message: e.message ?? "Bir hata meydana geldi",
        );
      }
    }
  }

  void clearFields() {
    titleController.clear();
    newUsernameList = [];
    notifyListeners();
  }
}
