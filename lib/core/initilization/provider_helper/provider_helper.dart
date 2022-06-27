import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../feature/viewmodel/chip_controller.dart';
import '../../../feature/viewmodel/food_viewmodel.dart';
import '../../../feature/viewmodel/order_viewmodel.dart';
import '../../../screen/admin/viewmodel/activation_viewmodel.dart';
import '../../../screen/admin/viewmodel/dropdown_viewmodel.dart';
import '../../../screen/admin/viewmodel/order_list_provider.dart';
import '../../../screen/admin/viewmodel/tabbar_controller.dart';
import '../../../screen/admin/viewmodel/textfield_provider.dart';
import '../../../screen/auth/screen_login/viewmodel/checkbox_provider.dart';
import '../../../screen/auth/screen_login/viewmodel/textfield_controller.dart';
import '../../../screen/auth/screen_register/provider/textfield_controller.dart';
import '../../../screen/home/controller/cart_controller.dart';
import '../../../screen/home/controller/image_controller.dart';
import '../../../screen/home/controller/index_controller.dart';
import '../../../screen/home/controller/url_controller.dart';
import '../../../screen/splash/viewmodel/splash_viewmodel.dart';
import '../../network/firebase/view-models/firebase_viewmodel.dart';

class ProviderHelper {
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => ChipController()),
    ChangeNotifierProvider(create: (_) => CartController()),
    ChangeNotifierProvider(create: (_) => DropDownController()),
    ChangeNotifierProvider(create: (_) => ImageController()),
    ChangeNotifierProvider(create: (_) => ActivationController()),
    ChangeNotifierProvider(create: (_) => CheckBoxController()),
    ChangeNotifierProvider(create: (_) => TabBarController()),
    Provider(create: (_) => RegisterTextController()),
    Provider(create: (_) => LoginTextController()),
    Provider(create: (_) => IndexController()),
    Provider(create: (_) => UrlController()),
    Provider(create: (_) => SplashController()),
    Provider(create: (_) => OrderListController()),
    Provider(create: (_) => AdminTextController()),
    ChangeNotifierProvider(create: (_) => OrderViewmodel()),
    ChangeNotifierProvider(create: (_) => FirebaseVmodel()),
    ChangeNotifierProvider(create: (_) => FoodViewmodel()),
  ];
}
