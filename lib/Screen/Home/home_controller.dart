import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:new_yogendra_task/Screen/Cart/cart_controller.dart';
import 'package:new_yogendra_task/Screen/Home/product_list_model.dart';
import '../../Utils/ReusableWidgets/reusable_snackbar.dart';
import '../../Utils/const_urls.dart';

class HomeController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  RxBool isLoading = true.obs;
  RxList<Data> itemList = <Data>[].obs;
  ProductListModel productListModel = ProductListModel();

  CartController cartController = Get.find<CartController>();

  @override
  void onReady() {
    getProduct();
    cartController.loadCartItems();
    super.onReady();
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      itemList.value = (productListModel.data ??[])
          .where((item) =>
              (item.name ?? "").toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      getProduct();
    }
  }

  Future<void> getProduct() async {
    final url = Uri.parse(ConstUrls.baseUrl + ConstUrls.productEndPoint);

    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      isLoading.value = true;
      final response = await http.get(url, headers: headers);

      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        productListModel = ProductListModel.fromJson(data);
        itemList.value = productListModel.data ?? [];
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showSnackBar(message: data.toString(), isForError: true);
      }
    } catch (e) {
      isLoading.value = false;
      showSnackBar(message: e.toString(), isForError: true);
      debugPrint(e.toString());
    }
  }
}
