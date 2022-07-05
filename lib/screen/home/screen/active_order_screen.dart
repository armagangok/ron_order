import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './home_screen.dart';
import '../../../core/components/components.dart';
import '../../../core/components/global_elevated_button.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/navigation/navigation.dart';
import '../../../core/network/firebase/view-models/firebase_viewmodel.dart';
import '../../../feature/components/snackbar.dart';
import '../../../feature/models/order_model.dart';
import '../../../feature/viewmodel/order_viewmodel.dart';

class ActiveOrderScreen extends StatelessWidget {
  const ActiveOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseVmodel firebase = Provider.of<FirebaseVmodel>(context);
    final OrderViewmodel orderViewmodel = Provider.of<OrderViewmodel>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Padding(
          padding: EdgeInsets.all(context.getWidth(0.025)),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              buildFoodGridView(firebase, orderViewmodel),
              const SizedBox004(),
            ],
          ),
        ),
      ),
    );
  }

  //

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          getBack(const HomeScreen(), context);
        },
        icon: const Icon(
          CupertinoIcons.back,
        ),
      ),
      title: AutoSizeText(
        "Aktif Siparişim",
        style: context.textTheme.labelMedium!.copyWith(
          fontWeight: FontWeight.w600,
          color: const Color(0xff32324D),
        ),
        maxFontSize: 18,
        minFontSize: 15,
      ),
    );
  }

  Widget buildFoodGridView(
      FirebaseVmodel firebaseVmodel, OrderViewmodel orderViewmodel) {
    return FutureBuilder<OrderModel>(
      future: OrderViewmodel().fetchActiveOrder(firebaseVmodel.user!.id!),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            var order = snapshot.data;

            return (order != null)
                ? Column(
                    children: [
                      ListView.builder(
                        itemCount: order.activeOrderList.length,
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: AutoSizeText(
                              order.activeOrderList[index].foodName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            subtitle: Text("Yemek Adedi: "
                                "${order.activeOrderList[index].amount}"),
                          );
                        },
                      ),
                      GlobalElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                content: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                          "Siparişleri silmek istiyor musunuz?"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              await orderViewmodel
                                                  .deleteActiveOrder(
                                                      firebaseVmodel.user!.id!)
                                                  .whenComplete(
                                                () {
                                                  getBack(const HomeScreen(),
                                                      context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    snackbarSuccess(
                                                        "Siparişler başarıyla silindi, yeni siparişleri ansayfadan seçebilirsiniz."),
                                                  );
                                                },
                                              );
                                            },
                                            child: const Text("SİL"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("İPTAL"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        text: "Sipariş Sil",
                      ),
                      Text("Yemek Eklenme tarihi: ${order.date}"),
                    ],
                  )
                : const Center(
                    child: Text("Şu anda aktif sipariş bulunmamaktadır."),
                  );

          default:
            return const Center(
              child: Text("Veriler için bekleniyor..."),
            );
        }
      },
    );
  }
}
