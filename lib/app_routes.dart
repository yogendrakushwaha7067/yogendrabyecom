import 'package:get/get.dart';
import 'package:new_yogendra_task/Screen/Address/address_controller.dart';
import 'package:new_yogendra_task/Screen/Address/add_address_screen.dart';
import 'package:new_yogendra_task/Screen/Address/my_address_screen.dart';
import 'package:new_yogendra_task/Screen/Cart/cart_controller.dart';
import 'package:new_yogendra_task/Screen/Cart/cart_screen.dart';
import 'package:new_yogendra_task/Screen/Home/home_controller.dart';
import 'package:new_yogendra_task/Screen/Home/home_screen.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(
      name: HomeScreen.routeName,
      page: () => const HomeScreen(),
      bindings: [
        BindingsBuilder.put(() => CartController()),
        BindingsBuilder.put(() => HomeController()),
      ],
    ),

    GetPage(
      name: CartScreen.routeName,
      page: () => const CartScreen(),
    ),

    GetPage(
      name: MyAddressPage.routeName,
      page: () => const MyAddressPage(),
      bindings: [
        BindingsBuilder.put(() => AddressController()),
      ],
    ),

    GetPage(
      name: AddAddressScreen.routeName,
      page: () => const AddAddressScreen(),
    ),
  ];
}
