import 'dart:convert';

class FoodModel {
  String imageUrl;
  String foodName;
  String category;
  bool isActive;
  String foodID;
  FoodModel({
    required this.imageUrl,
    required this.foodName,
    required this.category,
    required this.isActive,
    required this.foodID,
  });

  FoodModel copyWith({
    String? imageUrl,
    String? foodName,
    String? category,
    bool? isActive,
    String? foodID,
  }) {
    return FoodModel(
      imageUrl: imageUrl ?? this.imageUrl,
      foodName: foodName ?? this.foodName,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
      foodID: foodID ?? this.foodID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'foodName': foodName,
      'category': category,
      'isActive': isActive,
      'foodID': foodID,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      imageUrl: map['imageUrl'] ?? '',
      foodName: map['foodName'] ?? '',
      category: map['category'] ?? '',
      isActive: map['isActive'] ?? false,
      foodID: map['foodID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodModel.fromJson(String source) =>
      FoodModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FoodModel(imageUrl: $imageUrl, foodName: $foodName, category: $category, isActive: $isActive, foodID: $foodID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FoodModel &&
        other.imageUrl == imageUrl &&
        other.foodName == foodName &&
        other.category == category &&
        other.isActive == isActive &&
        other.foodID == foodID;
  }

  @override
  int get hashCode {
    return imageUrl.hashCode ^
        foodName.hashCode ^
        category.hashCode ^
        isActive.hashCode ^
        foodID.hashCode;
  }
}
