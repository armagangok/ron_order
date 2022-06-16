import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageController with ChangeNotifier {
  final ImagePicker picker = ImagePicker();

  XFile? image;

  Future pickImage() async {
    try {
      image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 40,
      );

      print(image!.path);

      image = XFile(image!.path);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
