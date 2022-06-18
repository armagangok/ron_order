import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tcard/tcard.dart';

import '../../../../core/extension/context_extension.dart';

import '../../../feature/models/food_model.dart';
import '../viewmodel/cart_viewmodel.dart';
import '../../../feature/viewmodel/food_viewmodel.dart';

class TCardWidget extends StatelessWidget {
  const TCardWidget({
    Key? key,
    required this.foodModel,
  }) : super(key: key);

  final FoodModel foodModel;

  @override
  Widget build(BuildContext context) {
    final double height = context.getHeight(1);
    final double width = context.getWidth(1);

    return SizedBox(
      width: double.infinity,
      height: height * 1,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                height: width * 1,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  color: Colors.redAccent,
                  image: DecorationImage(
                    image: NetworkImage(foodModel.imageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const Spacer(flex: 3),
              Column(
                children: [
                  AutoSizeText(
                    foodModel.foodName,
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelMedium,
                    maxLines: 2,
                  ),
                ],
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class TCardBuilder extends StatelessWidget {
  const TCardBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = context.getHeight(1);

    return FutureBuilder<List<FoodModel>>(
      future: FoodProvider().fetchAllFood(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var foods = snapshot.data!;
          return Consumer(
            builder: (context, CartViewmodel cartViewmodel, child) {
              return (foods.isEmpty)
                  ? const Center(
                      child: Text("No active food available"),
                    )
                  : TCard(
                      lockYAxis: true,
                      onForward: (index, info) {
                        (info.direction == SwipDirection.Right)
                            ? cartViewmodel.addFoodToCart(foods[index])
                            : {};
                      },
                      size: Size(
                        double.infinity,
                        height * 0.8,
                      ),
                      cards: generateCard(foods),
                    );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text("Waiting for data..."),
          );
        } else {
          return const Center(
            child: Text("Error occured"),
          );
        }
      },
    );
  }

  //

  List<Widget> generateCard(foods) {
    var tCardWidgets = List.generate(
      foods.length,
      (index) => TCardWidget(foodModel: foods[index]),
    );
    return tCardWidgets;
  }
}
