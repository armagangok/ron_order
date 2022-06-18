import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/components.dart';
import '../../../../core/components/global_textfield.dart';
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
      padding: const EdgeInsets.all(10),
      children: [
        GlobalTextField(
          hintText: "Enter Food Name",
          color: const Color.fromARGB(255, 252, 236, 187),
          controller: controller.foodController,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            DropdownWidget(),
            PickImageButton(),
          ],
        ),
        const SizedBox004(),
        const GalleryImage(),
        const UploadImageButton(),
      ],
    );
  }
}
