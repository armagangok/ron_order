import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ron_order/screen/admin/viewmodel/order_provider.dart';

import '../../../../core/components/components.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../../core/local/pdf_service.dart';
import '../../../feature/models/order_model.dart';
import '../../../feature/viewmodel/order_viewmodel.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderViewmodel>(context).fetchOrder();
    final PdfOrderService pdfService = PdfOrderService();
    OrderListProvider orderListProvider =
        Provider.of<OrderListProvider>(context);

    double h = context.getHeight(1);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          physics: const ClampingScrollPhysics(),
          children: [
            textWidget(context),
            const SizedBox004(),
            FutureBuilder<List<OrderModel>>(
              future: Provider.of<OrderViewmodel>(context).fetchOrder(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final List<OrderModel> orders = snapshot.data!;

                  orderListProvider.setOrderList = orders;

                  return buildOrders(orders, h);
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

  Row textWidget(BuildContext context) {
    return Row(
      children: [
        Text(
          "Ron Food Orders",
          style: context.textTheme.headline5,
        ),
      ],
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
        // mainAxisExtent: h * (0.3),
        mainAxisSpacing: 10,
      ),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                orders[index].orderer,
                style: context.textTheme.labelMedium!.copyWith(
                  fontSize: 16,
                ),
                maxLines: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: orders[index].orderList.length,
                    itemBuilder: (context, index1) {
                      return AutoSizeText(
                        orders[index].orderList[index1].foodName,
                        style: context.textTheme.subtitle1!.copyWith(
                          fontSize: 12,
                        ),
                        maxLines: 1,
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
