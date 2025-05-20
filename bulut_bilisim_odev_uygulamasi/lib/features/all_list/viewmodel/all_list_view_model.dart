import 'package:bulut_bilisim_odev_uygulamasi/core/cache/cache_manager.dart';
import 'package:bulut_bilisim_odev_uygulamasi/core/model/list_model.dart';
import 'package:bulut_bilisim_odev_uygulamasi/core/service/base_service.dart';
import 'package:bulut_bilisim_odev_uygulamasi/product/util/custom_dialogs.dart';
import 'package:bulut_bilisim_odev_uygulamasi/product/util/custom_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllListViewModel extends ChangeNotifier {
  String? currentUsername;
  final BaseService _follows = BaseService();
  int _followersCount = 0;

  int get followersCount => _followersCount;

  // Initialize username
  Future<void> init() async {
    await getUsername();
  }

  // Get the username from the cache
  Future<void> getUsername() async {
    final usernameFromCache = await CacheManager.instance.getUsername();

    if (usernameFromCache != null) {
      currentUsername = usernameFromCache;
    }
    notifyListeners();
  }

  // Future<void> followList(String listId) async {
  //   if (currentUsername == null) return;

  //   final listOwner = await getListOwner(listId); // liste sahibini bul
  //   if (listOwner == null) return;

  //   await _follows.sendFollowRequest(
  //     fromUsername: currentUsername!,
  //     toUsername: listOwner,
  //   );
  // }

  Future<bool> sendFollowRequestToUser(
    BuildContext context,
    String listId,
    String listOwner,
    String listTitle,
  ) async {
    try {
      CustomDialogs.showLoadingDialog(context: context);

      final currentUsername = this.currentUsername;
      if (currentUsername == null) return false;

      final alreadySent = await _follows.hasPendingFollowRequest(
        fromUsername: currentUsername,
        listId: listId,
      );

      if (alreadySent) {
        return false;
      }

      await _follows.sendFollowRequest(
        fromUsername: currentUsername,
        toUsername: listOwner,
        listId: listId,
        listTitle: listTitle,
      );

      if (context.mounted) {
        Navigator.pop(context);
        CustomDialogs.showSuccessDialog(
          context: context,
          message: "Takip isteği yollandı",
        );
      }
      return true;
    } on CustomException catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        CustomDialogs.showErrorDialog(
          context: context,
          message: "Bir hata meydana geldi",
        );
      }
      return false;
    }
  }

  // Filtreleme işlemi

  List<ListModel> _tumListeler = [];
  List<ListModel> _filtrelenmisListeler = [];

  List<ListModel> get filtrelenmisListeler => _filtrelenmisListeler;

  void setAllLists(List<ListModel> listeler) {
    _tumListeler = listeler;
    _filtrelenmisListeler = listeler;
    notifyListeners();
  }

  void ara(String kelime) {
    if (kelime.isEmpty) {
      _filtrelenmisListeler = _tumListeler;
    } else {
      _filtrelenmisListeler =
          _tumListeler
              .where(
                (liste) =>
                    liste.title!.toLowerCase().contains(kelime.toLowerCase()),
              )
              .toList();
    }
    notifyListeners();
  }

  String searchWord = "";

  void ara2(String kelime) {
    searchWord = kelime;
    notifyListeners();
  }
}
