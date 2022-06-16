import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extension/context_extension.dart';
import '../../../core/models/category_model.dart';
import '../viewmodel/chip_viewmodel.dart';

class ChipCategoryWidgetBuilder extends StatelessWidget {
  const ChipCategoryWidgetBuilder({
    Key? key,
    required this.isAdminView,
  }) : super(key: key);

  final bool isAdminView;

  @override
  Widget build(BuildContext context) {
    final ChipViewmodel chipController = Provider.of<ChipViewmodel>(context);

    final double height = context.getHeight(1);
    return SizedBox(
      height: height * 0.09,
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: chipController.getCategories.length,
        itemBuilder: (context, index) {
          return ChipCategoryWidget(
            index: index,
            isAdminView: isAdminView,
          );
        },
      ),
    );
  }
}

class ChipCategoryWidget extends StatelessWidget {
  const ChipCategoryWidget({
    Key? key,
    required this.index,
    required this.isAdminView,
  }) : super(key: key);

  final int index;
  final bool isAdminView;

  @override
  Widget build(BuildContext context) {
    final double height = context.getHeight(1);
    final double width = context.getWidth(1);
    final ChipViewmodel categoryController =
        Provider.of<ChipViewmodel>(context);
    final Category category = categoryController.getCategories[index];
    final Color primaryColor = context.theme.primaryColor;
    bool isSelected = category.isSelected;
    final String categoryName = category.categoryName;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.01,
        vertical: height * 0.001,
      ),
      child: FilterChip(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        labelPadding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.01,
        ),
        label: Text(
          categoryName,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        showCheckmark: false,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        selectedColor: primaryColor,
        selected: isSelected,
        onSelected: (value) {
          categoryController.changeCategory(categoryName, value, index);
          isSelected = value;
        },
      ),
    );
  }
}
