import 'package:cloud_firestore/cloud_firestore.dart';

class ListModel {
  String? uuid;
  String? title;
  Timestamp? creationDate;
  String? ownerUsername;
  List<String>? usersOfList;

  ListModel({
    this.uuid,
    this.title,
    this.creationDate,
    this.ownerUsername,
    this.usersOfList,
  });

  ListModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    title = json['title'];
    creationDate = json['creation_date'];
    ownerUsername = json['owner_username'];
    usersOfList = json['users_of_list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uuid'] = uuid;
    data['title'] = title;
    data['creation_date'] = creationDate;
    data['owner_username'] = ownerUsername;
    data['users_of_list'] = usersOfList;

    return data;
  }

  factory ListModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ListModel.fromJson(data..['uuid'] = doc.id);
  }
}
