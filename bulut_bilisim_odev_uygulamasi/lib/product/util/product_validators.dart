class ProductValidators {
  static String? validateNotEmptyAndMinTwo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Bu alan boş bırakılamaz.';
    }
    if (value.trim().length < 2) {
      return 'En az 2 karakter olmalı.';
    }
    return null;
  }
}
