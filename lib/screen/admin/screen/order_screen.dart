import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/components.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../../core/local/pdf_service.dart';
import '../../../global/models/order_model.dart';
import '../../../global/viewmodel/order_viewmodel.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);
  List<OrderModel> _orders = [];

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderViewmodel>(context).fetchOrder();
    final PdfOrderService pdfService = PdfOrderService();
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: context.getHeight(0.88),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                physics: const ClampingScrollPhysics(),
                children: [
                  textWidget(context),
                  const SizedBox004(),
                  Align(
                    child: SizedBox(
                      // height: context.getHeight(0.78),
                      // width: context.getWidth(0.7),
                      child: FutureBuilder<List<OrderModel>>(
                        future:
                            Provider.of<OrderViewmodel>(context).fetchOrder(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            final List<OrderModel> orders = snapshot.data!;

                            _orders = orders;

                            return buildOrders(orders);
                            // return buildOrders(orders);
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
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: context.getHeight(0.26),
                height: context.getHeight(0.05),
                child: ElevatedButton(
                  child: const Text("Send all orders"),
                  onPressed: () async {
                    final a = await pdfService.createOrder(_orders);
                    await pdfService.savePdfFile("ron_yemek_siparişler", a);
                  },
                ),
              )
            ],
          ),
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

  Widget buildOrders(List<OrderModel> orders) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              orders[index].orderer,
              style: context.textTheme.titleLarge,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: orders[index].orderList.length,
                  itemBuilder: (context, index1) {
                    return Text(orders[index].orderList[index1].foodName);
                  },
                )
              ],
            )
          ],
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox004(),
      itemCount: orders.length,
    );
  }
}
