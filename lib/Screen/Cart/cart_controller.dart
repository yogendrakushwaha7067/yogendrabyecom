import 'dart:convert';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Home/product_list_model.dart';

class CartController extends GetxController {
  RxList<Data> cartItems = <Data>[].obs;
  RxDouble subTotal=0.00.obs;
  @override
  void onReady() {
  loadCartItems();
    super.onReady();
  }

  Future<void> loadCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartJsonList = prefs.getStringList('cart');
    if (cartJsonList != null) {
      cartItems.value =
          cartJsonList.map((json) => Data.fromJson(jsonDecode(json))).toList();
    }
    totalCount();
  }

  void addToCart({required int id, required List<Data> itemList}) {
    Data productToAdd = itemList.firstWhere((item) => item.id == id);
      cartItems.value.add(productToAdd);
    saveCartItems();
    totalCount();
  }

  void removeFromCart(int  id) {
    Data productToRemove = cartItems.firstWhere((item) => item.id == id);
    cartItems.value.remove(productToRemove);

    saveCartItems();
    totalCount();
  }

  void updateCartItem(Data product, int newQuantity) {
    product.quantity = newQuantity;
    saveCartItems();
    totalCount();
  }

  void clearCart() {
    cartItems.value.clear();
    subTotal.value=0.0;
    saveCartItems();
  }

  Future<void> saveCartItems() async {
    cartItems.refresh();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartJsonList =
        cartItems.map((product) => jsonEncode(product.toJson())).toList();
    prefs.setStringList('cart', cartJsonList);

  }

  void totalCount() {
    subTotal.value = 0.0;
    for (int i = 0; i < cartItems.value.length; i++) {
      int quantity = cartItems.value[i].quantity ?? 0; // Default to 0 if quantity is null
      String priceString = cartItems.value[i].mainPrice.toString().replaceAll("KWD", ""); // Remove "KWD" if present
      double price = double.tryParse(priceString) ?? 0; // Parse the price as a double, default to 0 if parsing fails
      subTotal.value += quantity * price; // Calculate subtotal for each item and accumulate
    }
  }
}
