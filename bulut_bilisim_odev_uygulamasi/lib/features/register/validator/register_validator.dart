import 'package:flutter/material.dart';

class RegisterValidators {
  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Kullanıcı adı boş bırakılamaz';
    } else if (value.length < 3) {
      return 'Kullanıcı adı en az 3 karakter olmalı';
    }
    return null;
  }
 
  static String? validatePasswordConfirm(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Şifre tekrar alanı boş olamaz';
    } else if (value != originalPassword) {
      return 'Şifreler eşleşmiyor';
    }
    else if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalı';
    }
    return null;
  }
}
