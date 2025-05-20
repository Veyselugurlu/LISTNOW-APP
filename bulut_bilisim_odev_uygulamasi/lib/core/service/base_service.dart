import '../model/item_model.dart';
import '../model/list_model.dart';
import '../../product/util/custom_exception.dart';
import '../../product/util/product_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class IBaseService {
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<bool> login({required String username, required String password});
  Future<bool> register(String username, String password);
  Future<bool> checkUsernameExists(String username);

  Future<void> createList({required ListModel list});
  Future<void> deleteList({required String listId});
  Future<void> updateList({required ListModel list});

  Future<void> addProduct({required ItemModel item});
  Future<void> deleteProduct({required String itemId});
  Future<void> updateProduct({required ItemModel item});
  Future<ItemModel> searchWBarcodeProduct({
    required String listId,
    required String barcode,
  });

  Future<void> followList(String listId, String currentUsername);

  Future<void> sendFollowRequest({
    required String fromUsername,
    required String toUsername, // <-- eklendi
    required String listId,
    required String listTitle,
  });

  Future<bool> hasPendingFollowRequest({
    required String fromUsername,
    required String listId,
  });

  Future<void> declineRequest({required String notificationId});

  Future<void> acceptRequest({
    required String notificationId,
    required String listId,
    required String username,
  });
}

class BaseService extends IBaseService {
  @override
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    try {
      final querySnapshot =
          await _fireStore
              .collection("users")
              .where("username", isEqualTo: username)
              .limit(1)
              .get();

      if (querySnapshot.docs.isEmpty) {
        return false;
      }

      final userDoc = querySnapshot.docs.first.data();

      final hashedInputPassword = ProductUtil.hashPassword(password);

      final storedPassword = userDoc["password"];
      if (storedPassword is! String) return false;

      return userDoc["password"] == hashedInputPassword;
    } on FirebaseException catch (e) {
      throw CustomException(e.message ?? "Bir Hata Meydana Geldi");
    }
  }

  @override
  Future<bool> register(String username, String password) async {
    try {
      final exists = await checkUsernameExists(username);
      if (exists) return false;

      await _fireStore.collection('users').add({
        'username': username,
        'password': password,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return true;
    } catch (e) {
      print("Kayıt Hatası: $e");
      return false;
    }
  }

  @override
  Future<bool> checkUsernameExists(String username) async {
    try {
      final querySnapshot =
          await _fireStore
              .collection("users")
              .where("username", isEqualTo: username)
              .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Hata: $e");
      return false;
    }
  }

  @override
  Future<void> createList({required ListModel list}) async {
    try {
      await _fireStore.collection("lists").doc(list.uuid).set(list.toJson());
    } on FirebaseException catch (e) {
      throw CustomException(e.message ?? "Bir Hata Meydana Geldi");
    }
  }

  @override
  Future<void> deleteList({required String listId}) async {
    try {
      await _fireStore.collection("lists").doc(listId).delete();
    } on FirebaseException catch (e) {
      throw CustomException(e.message ?? "Bir Hata Meydana Geldi");
    }
  }

  @override
  Future<void> updateList({required ListModel list}) async {
    try {
      await _fireStore.collection("lists").doc(list.uuid).update(list.toJson());
    } on FirebaseException catch (e) {
      throw CustomException(e.message ?? "Bir Hata Meydana Geldi");
    }
  }

  @override
  Future<void> addProduct({required ItemModel item}) async {
    try {
      await _fireStore.collection("items").doc(item.uuid).set(item.toJson());
    } on FirebaseException catch (e) {
      throw CustomException(e.message ?? "Bir Hata Meydana Geldi");
    }
  }

  @override
  Future<void> deleteProduct({required String itemId}) async {
    try {
      await _fireStore.collection("items").doc(itemId).delete();
    } on FirebaseException catch (e) {
      throw CustomException(e.message ?? "Bir Hata Meydana Geldi");
    }
  }

  @override
  Future<void> updateProduct({required ItemModel item}) async {
    try {
      await _fireStore.collection("items").doc(item.uuid).update(item.toJson());
    } on FirebaseException catch (e) {
      throw CustomException(e.message ?? "Bir Hata Meydana Geldi");
    }
  }

  @override
  Future<void> followList(String listId, String currentUsername) async {
    try {
      final listRef = _fireStore.collection('lists').doc(listId);

      await listRef.update({
        'users_of_list': FieldValue.arrayUnion([currentUsername]),
      });
    } catch (e) {
      throw CustomException("Error following list: ${e.toString()}");
    }
  }

  @override
  Future<void> sendFollowRequest({
    required String fromUsername,
    required String toUsername,
    required String listId,
    required String listTitle,
  }) async {
    try {
      await _fireStore.collection("followstate").add({
        "user_from": fromUsername,
        "user_to": toUsername,
        "list_id": listId,
        "list_title": listTitle,
        "is_active": 1,
        "time": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw CustomException(
        "Takip isteği gönderilirken hata oluştu: ${e.toString()}",
      );
    }
  }

  @override
  Future<bool> hasPendingFollowRequest({
    required String fromUsername,
    required String listId,
  }) async {
    final query =
        await _fireStore
            .collection("followstate")
            .where("user_from", isEqualTo: fromUsername)
            .where("list_id", isEqualTo: listId)
            .where("is_active", isEqualTo: 1)
            .get();

    return query.docs.isNotEmpty;
  }

  @override
  Future<void> declineRequest({required String notificationId}) async {
    try {
      await FirebaseFirestore.instance
          .collection("followstate")
          .doc(notificationId)
          .update({"is_active": 0});
    } on FirebaseException catch (e) {
      throw CustomException(e.message ?? "Bir Hata Meydana Geldi");
    }
  }

  @override
  Future<void> acceptRequest({
    required String notificationId,
    required String listId,
    required String username,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("followstate")
          .doc(notificationId)
          .update({"is_active": 2});

      await FirebaseFirestore.instance.collection("lists").doc(listId).update({
        'users_of_list': FieldValue.arrayUnion([username]),
      });
    } on FirebaseException catch (e) {
      throw CustomException(e.message ?? "Bir Hata Meydana Geldi");
    }
  }

  @override
  Future<ItemModel> searchWBarcodeProduct({
    required String listId,
    required String barcode,
  }) async {
    try {
      final querySnapshot =
          await _fireStore
              .collection('items')
              .where('list_id', isEqualTo: listId)
              .where('barcode', isEqualTo: barcode)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        return ItemModel.fromDocument(querySnapshot.docs.first);
      } else {
        throw CustomException("Aranılan ürün bulunamadı");
      }
    } on FirebaseException catch (e) {
      throw CustomException(e.message ?? "Bir Hata Meydana Geldi");
    }
  }
}
