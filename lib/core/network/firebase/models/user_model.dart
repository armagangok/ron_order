import 'dart:convert';

class AppUser {
  String? id;
  String? email;
  String? userName;
  String? password;
  String? passwordRepeat;
  List? orderList;
  AppUser({
    this.id,
    this.email,
    this.userName,
    this.password,
    this.passwordRepeat,
    this.orderList,
  });

  AppUser copyWith({
    String? id,
    String? email,
    String? userName,
    String? password,
    String? passwordRepeat,
    List? orderList,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      passwordRepeat: passwordRepeat ?? this.passwordRepeat,
      orderList: orderList ?? this.orderList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'userName': userName,
      'password': password,
      'passwordRepeat': passwordRepeat,
      'orderList': orderList,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'],
      email: map['email'],
      userName: map['userName'],
      password: map['password'],
      passwordRepeat: map['passwordRepeat'],
      orderList: map['orderList'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppUser(id: $id, email: $email, userName: $userName, password: $password, passwordRepeat: $passwordRepeat, orderList: $orderList)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.id == id &&
        other.email == email &&
        other.userName == userName &&
        other.password == password &&
        other.passwordRepeat == passwordRepeat &&
        other.orderList == orderList;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        userName.hashCode ^
        password.hashCode ^
        passwordRepeat.hashCode ^
        orderList.hashCode;
  }
}
