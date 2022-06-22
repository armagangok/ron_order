final ConstText kText = ConstText();

class ConstText {
  static final ConstText _singleton = ConstText._internal();
  factory ConstText() => _singleton;
  ConstText._internal();

  String userNameEmpty = "Kullanıcı adı boş bırakılamaz.";
  String emailEmpty = "Emil boş bırakılamaz.";
  String passwordsEmpty = "Şifreler boş bırakılamaz.";
  String passwordsNotSame = "Şifreler aynı değil Lütfen kontrol ediniz.";
  String registrationSuccess =
      "Hesap başarıyla oluşturuldu. Lütfen giriş yapın.";

  String unknownError = "Bilinmeyen bir hata oluştu";

  Map<String, String> warningText = {
    "email-already-in-use":
        "Bu email zaten başka bir hesap tarafından kullanılıyor.",
    "invalid-email": "Email hatalı, lütfen emalinizi kontrol edin.",
  };
}
