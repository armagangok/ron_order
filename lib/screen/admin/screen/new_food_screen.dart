import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/components.dart';
import '../../../../core/components/global_textfield.dart';
import '../../../core/extension/context_extension.dart';
import '../components/components.dart';
import '../components/dropdown_widget.dart';
import '../viewmodel/textfield_provider.dart';

class AddNewFoodScreen extends StatelessWidget {
  const AddNewFoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdminTextController controller =
        Provider.of<AdminTextController>(context);

    return ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: context.getWidth(0.025)),
      children: [
        GlobalTextField(
          hintText: "Yemek adı giriniz",
          color: context.primaryColor.withOpacity(0.1),
          controller: controller.foodController,
        ),
        const SizedBox004(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            DropdownWidget(),
            PickImageButton(),
          ],
        ),
        const SizedBox004(),
        const GalleryImage(),
        const SizedBox004(),
        const UploadImageButton(),
      ],
    );
  }
}
