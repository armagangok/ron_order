import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extension/context_extension.dart';
import '../../../core/components/components.dart';
import '../../../core/navigation/navigation.dart';
import '../../../core/network/firebase/view-models/firebase_viewmodel.dart';
import '../../../feature/components/chip_category_widget.dart';
import '../../../feature/components/food_grid_view_builder.dart';
import '../../../feature/components/topbar_widget.dart';
import '../../../feature/viewmodel/chip_controller.dart';
import '../../../feature/viewmodel/food_viewmodel.dart';
import '../../admin/screen/admin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    FoodViewmodel().getAllFood(forAdmin: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = context.getHeight(1);
    final double width = context.getWidth(1);
    FirebaseVmodel firebase = Provider.of<FirebaseVmodel>(context);
    // final Color primaryColor = context.theme.primaryColor;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: buildAppBar(
          context.textTheme,
          width,
          firebase.user!.isAdmin,
        ),
        body: SafeArea(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: width * 0.025),
            children: [
              const ChipCategoryWidgetBuilder(),
              SizedBox(width: width * 0.01),
              buildFoodGridView()
            ],
          ),
        ),
      ),
    );
  }

  //

  Widget buildFoodGridView() {
    return Consumer(
      builder: (context, ChipController chip, _) {
        final FoodViewmodel foodProvider = Provider.of<FoodViewmodel>(context);

        switch (foodProvider.fetchedFoodList.isNotEmpty) {
          case true:
            return GridViewBuilderWidget(
              foodList: foodProvider.fetchedFoodList[chip.chosenCategory]!,
            );

          default:
            return Center(
              child: Column(
                children: [
                  Text(
                    "Yemek verileri için bekleniyor..",
                    style: context.textTheme.bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                  const SizedBox004(),
                  const CircularProgressIndicator(),
                ],
              ),
            );
        }
      },
    );
  }
  //

  AppBar buildAppBar(
    TextTheme textTheme,
    double width,
    bool isAdmin,
  ) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: const [
        TopBarWidget(),
      ],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isAdmin
              ? IconButton(
                  onPressed: () {
                    getToRemove(const AdminScreen(), context);
                  },
                  icon: const Icon(
                    CupertinoIcons.person,
                    color: Colors.black,
                  ),
                )
              : const SizedBox(),
          Expanded(
            child: Center(
              child: AutoSizeText(
                "Etibol Lokantası",
                style: textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff32324D),
                ),
                maxFontSize: 20,
                minFontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
