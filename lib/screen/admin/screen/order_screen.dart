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

    OrderListController orderListProvider =
        Provider.of<OrderListController>(context);

    double h = context.getHeight(1);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                            child:
                                Text("Şu anda aktif sipariş bulunmamaktadır."),
                          )
                        : buildOrders(orders, h);
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: Text("Yemek verileri getiriliyor..."),
                    );
                  } else {
                    return const Center(
                      child: Text("İnternet bağlantızı kontrol edin."),
                    );
                  }
                },
              ),
            ],
          ),
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: h * 0.15,
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
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
              ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(height: h * 0.008),
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                itemCount: orders[index].orderList.length,
                itemBuilder: (context, index1) {
                  return Row(
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          "${orders[index].orderList[index1].amount}x${orders[index].orderList[index1].foodName} ",
                          style: context.textTheme.subtitle1,
                          maxLines: 2,
                          maxFontSize: 12,
                        ),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}

class DeleteOrderDialog extends StatelessWidget {
  const DeleteOrderDialog({
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
    builder: (_) => DeleteOrderDialog(
      text: text,
      func: () async => await func(),
    ),
  );
}
