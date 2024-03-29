import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_yogendra_task/Screen/Cart/cart_controller.dart';
import 'package:new_yogendra_task/Screen/Home/home_controller.dart';
import 'package:new_yogendra_task/Utils/ReusableWidgets/reusable_image_with_shimmer.dart';
import '../const_urls.dart';

class ReusableItemView extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final int id;
  final bool isFavourite;
  final double itemHeight;


   ReusableItemView({
    super.key,
    required this.itemHeight,
    required this.name,
    required this.price,
    required this.image,
    required this.isFavourite, required this.id,
  });

 final CartController cartController = Get.find<CartController>();
 final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            height: itemHeight,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: ReusableImageWithShimmer(
                      isCircle: false,
                      url: ConstUrls.imageBaseUrl + image,
                      boxFit: BoxFit.cover,
                      height: itemHeight * .63),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          "4436 - 501/87 Black",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.pinkAccent,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          price,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
              top: 10,
              right: 10,
              child: Icon(
                Icons.favorite_border,
                color: Colors.grey,
              )),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap:(){
                cartController.addToCart(id: id, itemList: homeController.itemList,);
    },
              child: Container(
                width: 56,
                height: 35,
                decoration: const BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
