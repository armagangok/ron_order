import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../global/viewmodel/food_viewmodel.dart';
import '../../../global/viewmodel/order_viewmodel.dart';
import '../../../screen/admin/viewmodel/activation_viewmodel.dart';
import '../../../screen/admin/viewmodel/dropdown_viewmodel.dart';
import '../../../screen/auth/screen_login/viewmodel/textfield_controller.dart';
import '../../../screen/auth/screen_register/provider/textfield_controller.dart';
import '../../../screen/home/viewmodel/cart_viewmodel.dart';
import '../../../global/viewmodel/chip_viewmodel.dart';

import '../../../screen/home/viewmodel/image_provider.dart';
import '../../../screen/home/viewmodel/index_provider.dart';
import '../../../screen/home/viewmodel/menu_viewmodel.dart';

import '../../../screen/home/viewmodel/url_viewmodel.dart';
import '../../network/firebase/view-models/firebase_viewmodel.dart';

class ProviderHelper {
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => ChipViewmodel()),
    ChangeNotifierProvider(create: (_) => MenuViewmodel()),
    ChangeNotifierProvider(create: (_) => CartViewmodel()),
    ChangeNotifierProvider(create: (_) => FirebaseVmodel()),
    ChangeNotifierProvider(create: (_) => DropDownProvider()),
    ChangeNotifierProvider(create: (_) => ImageController()),
    ChangeNotifierProvider(create: (_) => ActivationViewmodel()),
    Provider(create: (_) => RegisterTextController()),
    Provider(create: (_) => LoginTextController()),
    Provider(create: (_) => OrderViewmodel()),
    Provider(create: (_) => IndexProvider()),
    Provider(create: (_) => UrlProvider()),
    Provider(create: (_) => FoodProvider()),

    // ChangeNotifierProvider(create: (_) => FirestoreVModel()),
  ];
}
