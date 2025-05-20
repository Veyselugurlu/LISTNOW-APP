import 'package:cloud_firestore/cloud_firestore.dart';

class FollowStateModel {
  final String id;
  final String userFrom;
  final String userTo;
  final String listId;
  final String listTitle;
  final int isActive;
  final Timestamp time;

  FollowStateModel({
    required this.id,
    required this.userFrom,
    required this.userTo,
    required this.listId,
    required this.listTitle,
    required this.isActive,
    required this.time,
  });

  factory FollowStateModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FollowStateModel(
      id: doc.id,
      userFrom: data['user_from'] ?? '',
      userTo: data['user_to'] ?? '',
      listId: data['list_id'] ?? '',
      listTitle: data['list_title'] ?? '',
      isActive: data['is_active'] ?? 0,
      time: data['time'],
    );
  }
}
