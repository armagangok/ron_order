final ConstText kText = ConstText();

class ConstText {
  static final ConstText _singleton = ConstText._internal();
  factory ConstText() => _singleton;
  ConstText._internal();

  String userNameEmpty = "Kullanıcı adı boş bırakılamaz.";
  String emailEmpty = "Emil boş bırakılamaz.";
  String passwordsEmpty = "Şifreler boş bırakılamaz.";
  String passwordsNotSame = "Şifreler aynı değil. Lütfen kontrol ediniz.";
  String registrationSuccess =
      "Hesap başarıyla oluşturuldu. Lütfen giriş yapın.";
  String loginSuccess = "Başarılı bir şekilde oturum açıldı.";
  String unknownError = "Bilinmeyen bir hata oluştu";
  String chooseAnotherCategory =
      "Ana yemeklerden sadece bir adet seçebilirsiniz.";
  String cartIsFull = "Yemek sepetiniz doldu. En fazla 3 yemek seçebilirsiniz.";
  String noImage = "Lütfen bir fotoğraf seçiniz";
  String foodNameEmpty = "Yemek adı boş bırakılamaz.";
  String picUploaded =
      "Yemek başarılı bir şekilde oluşturuldu ve sisteme yüklendi.";
  String only3Food = "Yemek sepetine en fazla 3 adet ekleyebilirsiniz.";
  String only1MainDish = "Sadece 1 tane ana yemek seçebilirsiniz.";

  Map<String, String> warningText = {
    "user-not-found": "Kullanıcı bulunamadı.",
    "email-already-in-use":
        "Bu email zaten başka bir hesap tarafından kullanılıyor.",
    "invalid-email": "Email hatalı, lütfen emalinizi kontrol edin.",
    "unknown": "Email ve şifre boş bırakılamaz.",
    "wrong-password": "Hatalı şifre girişi.",
    "too-many-requests": "İstek aşımı yapıldı. Daha sonra tekrar deneyiniz."
  };
}
