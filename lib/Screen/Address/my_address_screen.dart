import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_yogendra_task/Screen/Address/address_controller.dart';
import 'package:new_yogendra_task/Screen/Address/add_address_screen.dart';

class MyAddressPage extends GetView<AddressController> {
  const MyAddressPage({super.key});

  static const String routeName = "/myAddressPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Addresses'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Obx(
                  () {
                if (controller.myAddressList.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Address',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: controller.myAddressList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            title: Text(controller.myAddressList[index]),
                            onTap: (){
                              controller.startPayment();
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(AddAddressScreen.routeName);
              },
              child: const Text('Add New Address'),
            ),
          ),
        ],
      ),
    );
  }
}
