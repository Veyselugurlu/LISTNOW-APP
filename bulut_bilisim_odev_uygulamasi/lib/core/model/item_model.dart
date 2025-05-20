import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String? uuid;
  String? listId;
  Timestamp? creationDate;
  String? owner;
  String? title;
  String? content;
  String? barcode;

  ItemModel({
    this.uuid,
    this.listId,
    this.creationDate,
    this.owner,
    this.title,
    this.content,
    this.barcode,
  });

  ItemModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    listId = json['list_id'];
    creationDate = json['creation_date'];
    owner = json['owner'];
    title = json['title'];
    content = json['content'];
    barcode = json['barcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uuid'] = uuid;
    data['list_id'] = listId;
    data['creation_date'] = creationDate;
    data['owner'] = owner;
    data['title'] = title;
    data['content'] = content;
    data['barcode'] = barcode;
    return data;
  }

  factory ItemModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ItemModel.fromJson({...data, 'uuid': doc.id});
  }
}
