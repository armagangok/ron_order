import 'package:uuid/uuid.dart';

class UniqueIDProvider {
  final Uuid generateFoodUD = const Uuid();

  String generateUID() {
    return generateFoodUD.v1();
  }
}
