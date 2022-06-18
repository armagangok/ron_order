import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/global_elevated_button.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/tools/uuid_provider.dart';
import '../../../feature/models/food_model.dart';
import '../../../feature/models/storage_model.dart';
import '../../../feature/viewmodel/order_viewmodel.dart';

import '../../auth/screen_register/components/dialogs.dart';
import '../../home/viewmodel/image_provider.dart';
import '../viewmodel/dropdown_viewmodel.dart';
import '../viewmodel/textfield_provider.dart';

class UploadImageButton extends StatelessWidget {
  const UploadImageButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderViewmodel orderViewmodel = OrderViewmodel();
    final DropDownProvider dropDown = Provider.of<DropDownProvider>(context);
    final ImageController imageProvider = Provider.of<ImageController>(context);
    final AdminTextController controller =
        Provider.of<AdminTextController>(context);

    return GlobalElevatedButton(
      text: "Upload Image To Database",
      onPressed: () async {
        File? fileToUpload;
        if (imageProvider.image == null) {
          await dialog(context, "Please choose a food photo.");
        } else {
          if (controller.food.text == "") {
            await dialog(context, "Food name cannot be empty.");
          } else {
            fileToUpload = File(imageProvider.image!.path);
            StorogeFoodModel storageModel = StorogeFoodModel(
              file: fileToUpload,
              foodModel: FoodModel(
                imageUrl: "imageUrl",
                foodName: controller.foodController.text,
                category: dropDown.dropDownValue,
                isActive: true,
                foodID: UniqueIDProvider().generateUID(),
              ),
            );

            await orderViewmodel.uploadFoodToStorage(storageModel);

            dialog(context, "Food has been uploaded.");
          }
        }
      },
    );
  }
}

//
//

class PickImageButton extends StatelessWidget {
  const PickImageButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImageController imageProvider = Provider.of<ImageController>(context);
    return TextButton(
      child: const Text("Pick Image"),
      onPressed: () async => await imageProvider.pickImage(),
    );
  }
}

//
//

class GalleryImage extends StatelessWidget {
  const GalleryImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImageController imageProvider = Provider.of<ImageController>(context);
    final h = context.getHeight(1);

    return (imageProvider.image == null)
        ? const SizedBox()
        : SizedBox(
            height: h * (0.35),
            child: Image.file(
              imageProvider.image!,
              fit: BoxFit.fill,
            ),
          );
  }
}
