import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/components.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../feature/models/order_model.dart';
import '../../../feature/viewmodel/order_viewmodel.dart';
import '../viewmodel/order_list_provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderViewmodel>(context).fetchOrder();

    OrderListProvider orderListProvider =
        Provider.of<OrderListProvider>(context);

    double h = context.getHeight(1);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          physics: const ClampingScrollPhysics(),
          children: [
            Center(child: textWidget(context)),
            const SizedBox004(),
            FutureBuilder<List<OrderModel>>(
              future: Provider.of<OrderViewmodel>(context).fetchOrder(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final List<OrderModel> orders = snapshot.data!;

                  orderListProvider.setOrderList = orders;

                  return orders.isEmpty
                      ? const Center(
                          child: Text("There is no active order recently."),
                        )
                      : buildOrders(orders, h);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: Text("Waiting for data..."),
                  );
                } else {
                  return const Center(
                    child: Text("Check your internet connection."),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget textWidget(BuildContext context) {
    return Text(
      "Ron Food Orders",
      style: context.textTheme.headline5,
    );
  }

  //

  Widget buildOrders(List<OrderModel> orders, h) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          tileColor: const Color.fromARGB(255, 255, 240, 196),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                orders[index].orderer,
                style: context.textTheme.labelMedium,
                maxLines: 1,
                maxFontSize: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemCount: orders[index].orderList.length,
                    itemBuilder: (context, index1) {
                      return AutoSizeText(
                        orders[index].orderList[index1].foodName,
                        style: context.textTheme.subtitle1,
                        maxLines: 1,
                        minFontSize: 12,
                      );
                    },
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class DeleteFoodDialog extends StatelessWidget {
  const DeleteFoodDialog({
    Key? key,
    required this.text,
    required this.func,
  }) : super(key: key);

  final Function func;
  final String text;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Column(
        children: [
          Text(text),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  return await func();
                },
                child: const Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<void> buildDialog(
  context,
  Function func,
  String text,
) async {
  await showDialog(
    context: context,
    builder: (_) => DeleteFoodDialog(
      text: text,
      func: () async => await func(),
    ),
  );
}
