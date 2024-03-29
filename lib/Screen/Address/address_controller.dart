import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_yogendra_task/Screen/Home/home_screen.dart';
import 'package:new_yogendra_task/Utils/ReusableWidgets/reusable_snackbar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Cart/cart_controller.dart';

class AddressController extends GetxController {
  late GoogleMapController mapController;
  RxString markerInfo = ''.obs;
  Rx<LatLng> selectedLocation = const LatLng(0.0, 0.0).obs;
  RxList<String> myAddressList = <String>[].obs;
  late Razorpay _razorpay;
        @override
  void onInit() {
    // TODO: implement onInit
          _razorpay = Razorpay();
          _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
          _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
          _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.onInit();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  final CartController cartController = Get.find<CartController>();
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    print("Payment Successful: ${response.paymentId}");
    cartController.clearCart();
    showSnackBar(message: "Order  Successful");
    Get.toNamed(HomeScreen.routeName);
    // You can navigate to a success screen or do any other necessary actions
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    print("Payment Error: ${response.code.toString()} - ${response.message}");
    // You can show an error message or try again option
    showSnackBar(
        message: "Payment Error!",
        isForError: true);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
    print("External Wallet: ${response.walletName}");
    // You can implement specific logic if payment is done via external wallets like Paytm, etc.
  }

  void startPayment() {
    double res = double.parse("${cartController.subTotal.value}");
    int pricerazorpayy= int.parse(res.toStringAsFixed(0)) * 100;
    // print("checking razorpay price ${pricerazorpayy.toString()}");
    //
    // print("checking razorpay price ${pricerazorpayy.toString()}");
    // Navigator.of(context).pop();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': "${pricerazorpayy}",
      'name': 'test',
      'image':'assets/splash/splashimages.png',
      'description': 'test',
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void updateSelectedLocation(LatLng location) {
    markerInfo.value =
        'Lat: ${location.latitude.toStringAsFixed(5)}, Lng: ${location.longitude.toStringAsFixed(5)}';
    selectedLocation.value = location;
  }

  Future<void> saveSelectedAddress() async {
    if (selectedLocation.value != const LatLng(0.0, 0.0)) {
      final prefs = await SharedPreferences.getInstance();

      List<Placemark> placeMarks = await placemarkFromCoordinates(
          selectedLocation.value.latitude, selectedLocation.value.longitude);

      if (placeMarks != null && placeMarks.isNotEmpty) {
        Placemark first = placeMarks.first;
        String address =
            "${first.name}, ${first.thoroughfare}, ${first.locality}, ${first.administrativeArea} ${first.postalCode}, ${first.country}";
        myAddressList.value.add(address);
        myAddressList.refresh();
        prefs.setStringList('addresses', myAddressList);
        showSnackBar(message: "Address saved successfully");
      } else {
        showSnackBar(
            message: "Error occurred, while saving your address!",
            isForError: true);
      }
    } else {
      showSnackBar(
          message: "Please select a delivery address first!", isForError: true);
    }
  }


  Future<void> getSavedAddress()async {
    final prefs = await SharedPreferences.getInstance();
    myAddressList.value = prefs.getStringList('addresses') ?? [];
  }

}
