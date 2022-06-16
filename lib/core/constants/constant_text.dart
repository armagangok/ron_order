class ConstText {
  static final ConstText _singleton = ConstText._internal();
  factory ConstText() => _singleton;
  ConstText._internal();

  static String registerErrorText = "There may be an account with that email.";

  static String verification = """\nHello There!\n
    Verification link has been sent your e-mail.\n
    Do you really think that you can signin without verification? \n""";

  static String emptyLogin = "Password and email fields cannot be empty.";
}
