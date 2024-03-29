import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:new_yogendra_task/Screen/Cart/cart_controller.dart';
import 'package:new_yogendra_task/Screen/Cart/cart_screen.dart';
import '../utils.dart';

class ReusableGetCartButton extends StatelessWidget {
  ReusableGetCartButton({
    super.key,
  });

  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(CartScreen.routeName);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: badges.Badge(
          badgeContent: Obx(() {
            return Text(
              (cartController.cartItems.length).toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            );
          }),
          position: badges.BadgePosition.topEnd(top: -15, end: -8),
          badgeStyle: badges.BadgeStyle(
            badgeColor: Colors.black,
            padding: const EdgeInsets.all(5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(
            Icons.shopping_cart_outlined,
            size: 28,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
