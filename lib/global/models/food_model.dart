import 'dart:convert';

class FoodModel {
  String imageUrl;
  String foodName;
  int amount = 0;
  String category;
  bool isActive;
  String foodID;
  FoodModel({
    required this.imageUrl,
    required this.foodName,
    required this.amount,
    required this.category,
    required this.isActive,
    required this.foodID,
  });
  

  FoodModel copyWith({
    String? imageUrl,
    String? foodName,
    int? amount,
    String? category,
    bool? isActive,
    String? foodID,
  }) {
    return FoodModel(
      imageUrl: imageUrl ?? this.imageUrl,
      foodName: foodName ?? this.foodName,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
      foodID: foodID ?? this.foodID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'foodName': foodName,
      'amount': amount,
      'category': category,
      'isActive': isActive,
      'foodID': foodID,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      imageUrl: map['imageUrl'] ?? '',
      foodName: map['foodName'] ?? '',
      amount: map['amount']?.toInt() ?? 0,
      category: map['category'] ?? '',
      isActive: map['isActive'] ?? false,
      foodID: map['foodID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodModel.fromJson(String source) => FoodModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FoodModel(imageUrl: $imageUrl, foodName: $foodName, amount: $amount, category: $category, isActive: $isActive, foodID: $foodID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is FoodModel &&
      other.imageUrl == imageUrl &&
      other.foodName == foodName &&
      other.amount == amount &&
      other.category == category &&
      other.isActive == isActive &&
      other.foodID == foodID;
  }

  @override
  int get hashCode {
    return imageUrl.hashCode ^
      foodName.hashCode ^
      amount.hashCode ^
      category.hashCode ^
      isActive.hashCode ^
      foodID.hashCode;
  }
}
