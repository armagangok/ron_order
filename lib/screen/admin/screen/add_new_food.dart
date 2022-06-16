import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uuid/uuid.dart';

import '../../../../core/components/components.dart';
import '../../../../core/components/global_elevated_button.dart';
import '../../../../core/components/global_textfield.dart';
import '../../../core/models/food_model.dart';
import '../../../core/models/storage_model.dart';
import '../../../core/extension/context_extension.dart';
import '../../home/viewmodel/image_provider.dart';
import '../../home/viewmodel/order_viewmodel.dart';
import '../components/dropdown_widget.dart';
import '../viewmodel/dropdown_viewmodel.dart';

class AddNewFoodScreen extends StatelessWidget {
  AddNewFoodScreen({Key? key}) : super(key: key);

  final TextEditingController food = TextEditingController();

  var generateFoodUD = const Uuid();

  @override
  Widget build(BuildContext context) {
    final OrderViewmodel orderViewmodel = OrderViewmodel();
    final DropDownProvider dropDown = Provider.of<DropDownProvider>(context);
    final ImageController imageProvider = Provider.of<ImageController>(context);
    final h = context.getHeight(1);
    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(10),
      children: [
        GlobalTextField(
          hintText: "Enter Food Name",
          color: const Color.fromARGB(255, 252, 236, 187),
          controller: food,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const DropdownWidget(),
            TextButton(
              child: const Text("Pick Image"),
              onPressed: () async => await imageProvider.pickImage(),
            ),
          ],
        ),
        const SizedBox004(),
        buildImage(h, imageProvider.image),
        GlobalElevatedButton(
          text: "Upload Image To Database",
          onPressed: () async {
            final File fileToUpload = File(imageProvider.image!.path);
            StorogeModel model = StorogeModel(
              file: fileToUpload,
              foodModel: FoodModel(
                imageUrl: "imageUrl",
                foodName: food.text,
                category: dropDown.dropDownValue,
                isActive: true,
                foodID: generateFoodID(),
              ),
            );
            await orderViewmodel.uploadFoodToStorage(model);
          },
        ),
      ],
    );
  }

  Widget buildImage(double h, image) {
    return (image == null)
        ? const SizedBox()
        : SizedBox(
            height: h * (0.3),
            child: Image.asset(
              image!.path,
              fit: BoxFit.fill,
            ),
          );
  }

  String generateFoodID() {
    return generateFoodUD.v1();
  }
}
