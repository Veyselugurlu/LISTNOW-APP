import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

class ProductUtil {
  static String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  static String formatTimestamp(Timestamp timestamp) {
    return DateFormat('dd.MM.yyyy HH:mm').format(timestamp.toDate());
  }
}
