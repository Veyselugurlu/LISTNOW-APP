class LoginValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-posta adresi boş olamaz';
    }
    const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(emailPattern);
    if (!regex.hasMatch(value)) {
      return 'Geçersiz e-posta adresi';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen şifre giriniz';
    }
    const minPasswordLength = 6;
    const passwordPattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    final regex = RegExp(passwordPattern);

    if (value.length < minPasswordLength) {
      return 'Şifre en az $minPasswordLength karakter olmalıdır';
    }
    if (!regex.hasMatch(value)) {
      return 'Büyük harf, küçük harf, rakam ve özel karakter içermeli';
    }
    return null;
  }
}
