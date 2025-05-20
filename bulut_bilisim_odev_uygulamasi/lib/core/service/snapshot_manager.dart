import 'package:bulut_bilisim_odev_uygulamasi/core/model/folow_state_model.dart';

import '../model/item_model.dart';
import '../model/list_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SnapshotManager extends ChangeNotifier {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Stream<List<ListModel>> allListSnapshot(String searchWord, String username) {
    return fireStore
        .collection("lists")
        .where("owner_username", isNotEqualTo: username)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => ListModel.fromDocument(doc))
                  .where(
                    (list) => !(list.usersOfList?.contains(username) ?? true),
                  )
                  .where(
                    (list) =>
                        list.title?.toLowerCase().contains(
                          searchWord.toLowerCase(),
                        ) ??
                        false,
                  )
                  .toList(),
        );
  }

  Stream<List<ListModel>> listSnapshot(String username) {
    return fireStore
        .collection("lists")
        .where("owner_username", isEqualTo: username)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => ListModel.fromDocument(doc)).toList(),
        );
  }

  Stream<List<ListModel>> joinedListSnapshot(String username) {
    return fireStore
        .collection("lists")
        .where("users_of_list", arrayContains: username)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => ListModel.fromDocument(doc)).toList(),
        );
  }

  Stream<List<ItemModel>> getListItems(String listId) {
    return fireStore
        .collection('items')
        .where('list_id', isEqualTo: listId)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => ItemModel.fromDocument(doc)).toList(),
        );
  }

  Stream<List<FollowStateModel>> getActiveFollowNotifications(String username) {
    return fireStore
        .collection("followstate")
        .where("user_to", isEqualTo: username)
        .where("is_active", isEqualTo: 1)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => FollowStateModel.fromDocument(doc))
                  .toList(),
        );
  }

  Stream<bool> followRequestStatusStream(String fromUsername, String listId) {
    return fireStore
        .collection("followstate")
        .where("user_from", isEqualTo: fromUsername)
        .where("list_id", isEqualTo: listId)
        .where("is_active", isEqualTo: 1)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty);
  }
}
