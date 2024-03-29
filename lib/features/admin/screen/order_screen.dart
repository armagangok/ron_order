import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/components.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../feature/models/order_model.dart';
import '../../../feature/viewmodel/order_viewmodel.dart';
import '../viewmodel/order_list_provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    OrderViewmodel().getOrderList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderViewmodel>(context).fetchOrder();

    OrderController orderListProvider = Provider.of<OrderController>(context);

    double height = context.getHeight(1);
    double width = context.getWidth(1);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(
              vertical: height * 0.02,
              horizontal: width * 0.03,
            ),
            physics: const ClampingScrollPhysics(),
            children: [
              Center(child: textWidget(context)),
              const SizedBox004(),
              FutureBuilder<List<OrderModel>>(
                future: Provider.of<OrderViewmodel>(context).fetchOrder(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      final List<OrderModel> orders = snapshot.data!;
                      orderListProvider.setOrderList = orders;
                      return orders.isEmpty
                          ? const Center(
                              child: Text(
                                "Şu anda aktif sipariş bulunmamaktadır.",
                              ),
                            )
                          : buildOrders(orders, height);

                    case ConnectionState.waiting:
                      return const Center(
                        child: Text("Yemek verileri getiriliyor..."),
                      );

                    default:
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

  //
  Widget textWidget(BuildContext context) {
    return Text(
      "Ron Yemek Siparişleri",
      style: context.textTheme.headline5,
    );
  }

  //
  Widget buildOrders(List<OrderModel> orders, double height) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   mainAxisExtent: height * 0.15,
      //   crossAxisCount: 2,
      //   crossAxisSpacing: 10,
      //   mainAxisSpacing: 10,
      // ),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: context.getWidth(0.025)),
          child: ListTile(
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            tileColor: const Color.fromARGB(255, 255, 240, 196),
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        SizedBox(height: height * 0.006),
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemCount: orders[index].activeOrderList.length,
                    itemBuilder: (context, index1) {
                      return Row(
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              "${orders[index].activeOrderList[index1].amount}x${orders[index].activeOrderList[index1].foodName} ",
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
            ),
          ),
        );
      },
    );
  }
}
