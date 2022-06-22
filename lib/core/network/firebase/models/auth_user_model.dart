// import 'dart:convert';

// class AuthUserModel {
//   String? id;
//   String? email;
//   String? userName;
//   List? orderList;
//   bool isAdmin;

//   AuthUserModel({
//     this.id,
//     this.email,
//     this.userName,
//     this.orderList,
//     this.isAdmin = false,
//   });

//   AuthUserModel copyWith({
//     String? id,
//     String? email,
//     String? userName,
//     List? orderList,
//     bool? isAdmin,
//   }) {
//     return AuthUserModel(
//       id: id ?? this.id,
//       email: email ?? this.email,
//       userName: userName ?? this.userName,
//       orderList: orderList ?? this.orderList,
//       isAdmin: isAdmin ?? this.isAdmin,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'email': email,
//       'userName': userName,
//       'orderList': orderList,
//       'isAdmin': isAdmin,
//     };
//   }

//   factory AuthUserModel.fromMap(Map<String, dynamic> map) {
//     return AuthUserModel(
//       id: map['id'],
//       email: map['email'],
//       userName: map['userName'],
//       orderList: map['orderList'] ,
//       isAdmin: map['isAdmin'] ?? false,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory AuthUserModel.fromJson(String source) => AuthUserModel.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'AuthUserModel(id: $id, email: $email, userName: $userName, orderList: $orderList, isAdmin: $isAdmin)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
  
//     return other is AuthUserModel &&
//       other.id == id &&
//       other.email == email &&
//       other.userName == userName &&
//       other.orderList == orderList &&
//       other.isAdmin == isAdmin;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//       email.hashCode ^
//       userName.hashCode ^
//       orderList.hashCode ^
//       isAdmin.hashCode;
//   }
// }
