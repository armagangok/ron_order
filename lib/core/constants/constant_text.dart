class ConstText {
  static final ConstText _singleton = ConstText._internal();
  factory ConstText() => _singleton;
  ConstText._internal();

  static String registerErrorText = "There may be an account with that email.";

  static String verification = """\nHello There!\n
    You have just registered a new account.""";

  static String emptyLogin = "Password and email fields cannot be empty.";
}
