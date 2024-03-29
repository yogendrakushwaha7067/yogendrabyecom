import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_yogendra_task/Screen/Address/my_address_screen.dart';
import 'package:new_yogendra_task/Screen/Home/home_controller.dart';
import 'package:new_yogendra_task/Utils/ReusableWidgets/reusable_get_cart_button.dart';
import 'package:new_yogendra_task/Utils/ReusableWidgets/reusable_text_field.dart';
import '../../Utils/ReusableWidgets/reusable_item_view.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  static const String routeName = "/homeScreen";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const double itemHeight = 300;
    final double itemWidth = size.width / 2;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Sunglasses",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        ReusableGetCartButton(),
                        IconButton(
                            onPressed: () {
                              Get.toNamed(
                                MyAddressPage.routeName,
                              );
                            },
                            icon: const Icon(
                              Icons.location_city_rounded,
                              size: 32,
                            ))
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ReusableTextField(
                        controller: controller.searchTextController,
                        hint: "Search",
                        borderRadius: 32,
                        fillColor: Colors.grey.withOpacity(.2),
                        hintTextColor: Colors.grey,
                        onChanged: controller.filterSearchResults,
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(16)),
                      child: const Icon(
                        Icons.sort,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(() {
                  return GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (itemWidth / itemHeight),
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemCount: controller.itemList.length,
                      itemBuilder: (context, index) {
                        if (controller.isLoading.value) {
                          return Container(
                            height: 100,
                            color: Colors.white,
                            child: const Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          );
                        }
                        return ReusableItemView(
                          itemHeight: itemHeight,
                          name: controller.itemList[index].name ?? "",
                          price: controller.itemList[index].mainPrice ?? "",
                          image:
                              controller.itemList[index].thumbnailImage ?? "",
                          isFavourite:
                              controller.itemList[index].isFavourist ?? false,
                          id: controller.itemList[index].id ?? -1,
                        );
                      });
                }),
                const SizedBox(
                  height: 32,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
