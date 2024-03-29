import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_yogendra_task/Screen/Cart/cart_controller.dart';
import 'package:new_yogendra_task/Screen/Home/product_list_model.dart';
import 'package:new_yogendra_task/Utils/ReusableWidgets/reusable_image_with_shimmer.dart';

import '../../Utils/const_urls.dart';
import '../Address/my_address_screen.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});
  static const String routeName = "/cartScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        elevation: 0,
      ),
      bottomNavigationBar:controller.cartItems.value.isEmpty?SizedBox.shrink():  Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          height: 200,
          child: Column(
            children: [
              DottedBorder(
                borderType: BorderType.RRect,
                color: Colors.grey,
                radius: const Radius.circular(12),
                padding: const EdgeInsets.all(6),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    height: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child:  Column(
                      children: [
                        const SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Cart Sub Total",style: TextStyle(color: Colors.pinkAccent,fontSize: 15,fontWeight: FontWeight.bold),),

                            Obx(
                               () {
                                return Text("KWD ${controller.subTotal.value}",style: const TextStyle(color: Colors.pinkAccent,fontSize: 15,fontWeight: FontWeight.bold),);
                              }
                            )
                          ],
                        ),

                        const Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text("SubTotal(${controller.cartItems.length} items)",style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.bold),),

                            Obx(
                                    () {
                                  return Text("KWD ${controller.subTotal.value}",style: const TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.bold),);
                                }
                            )
                          ],
                        ),


                      ],
                    ),
                  )
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(MyAddressPage.routeName);
                  },
                  child: const Text('Select Address'),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () => controller.cartItems.value.isEmpty
            ? const Center(
                child: Text('Your cart is empty.'),
              )
            : ListView.builder(
                itemCount: controller.cartItems.value.length,
                itemBuilder: (context, index) {
                  Data product = controller.cartItems.value[index];
                  return ListTile(
                    leading:  ReusableImageWithShimmer(
                        isCircle: false,
                        url: ConstUrls.imageBaseUrl +( product.thumbnailImage ??""),
                        boxFit: BoxFit.cover,
                        borderRadius: 16,
                        height: 60),

                    title: Text(product.name ?? ""),
                    subtitle: Text('Quantity: ${product.quantity??0}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        IconButton(
                          icon: const Icon(Icons.add,color: Colors.green,),
                          onPressed: () {
                            controller.updateCartItem(
                                product, (product.quantity ?? 0) + 1);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove,color: Colors.amber,),
                          onPressed: () {
                            if ((product.quantity ?? 0) > 1) {
                              controller.updateCartItem(
                                  product, (product.quantity ?? 0) - 1);
                            } else {
                              controller.removeFromCart(product.id ?? -1);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete,color: Colors.red,),
                          onPressed: () {
                            controller.removeFromCart(product.id ?? -1);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: controller.clearCart,
      //   child: const Icon(Icons.clear),
      // ),
    );
  }
}
