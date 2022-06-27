import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/global_elevated_button.dart';
import '../../../core/constants/constant_text.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/tools/uuid_provider.dart';
import '../../../feature/components/snackbar.dart';
import '../../../feature/models/food_model.dart';
import '../../../feature/models/storage_model.dart';
import '../../../feature/viewmodel/order_viewmodel.dart';
import '../../home/controller/image_controller.dart';
import '../viewmodel/dropdown_viewmodel.dart';
import '../viewmodel/textfield_provider.dart';

class UploadImageButton extends StatelessWidget {
  const UploadImageButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderViewmodel orderViewmodel = OrderViewmodel();
    final DropDownController dropDown =
        Provider.of<DropDownController>(context);
    final ImageController imageProvider = Provider.of<ImageController>(context);
    final AdminTextController controller =
        Provider.of<AdminTextController>(context);

    return GlobalElevatedButton(
      text: "Upload Image To Database",
      onPressed: () async {
        File? fileToUpload;
        if (imageProvider.image == null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(getSnackBar(kText.noImage));
        } else {
          if (controller.foodController.text == "") {
            ScaffoldMessenger.of(context).showSnackBar(
              getSnackBar(kText.foodNameEmpty),
            );
          } else {
            fileToUpload = File(imageProvider.image!.path);
            StorogeFoodModel storageModel = StorogeFoodModel(
              file: fileToUpload,
              foodModel: FoodModel(
                amount: 0,
                imageUrl: "imageUrl",
                foodName: controller.foodController.text,
                category: dropDown.dropDownValue,
                isActive: true,
                foodID: UniqueIDProvider().generateUID(),
              ),
            );

            try {
              ScaffoldMessenger.of(context).showSnackBar(
                snackbarSuccess(kText.picUploaded),
              );
              await orderViewmodel.uploadFoodToStorage(storageModel);
              controller.foodController.clear();
              imageProvider.image = null;
              fileToUpload = null;
            } on FirebaseException catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                getSnackBar(e.message!),
              );
            }
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
      onPressed: () async {
        return await imageProvider.pickImage();
      },
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

class TabBarWidget extends StatelessWidget {
  final String text;

  final Color color;

  const TabBarWidget({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.getHeight(1);
    final w = context.getWidth(1);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        color: color,
      ),
      height: h * 0.065,
      width: double.infinity,
      child: Center(
        child: AutoSizeText(
          text,
          textAlign: TextAlign.center,
          maxLines: 1,
          // style: context.textTheme.labelSmall!.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
