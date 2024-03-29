import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_yogendra_task/Screen/Address/address_controller.dart';

class AddAddressScreen extends GetView<AddressController> {
  const AddAddressScreen({super.key});

  static const String routeName = "/addressScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Delivery Address'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
           await   controller.saveSelectedAddress();
              Navigator.pop(context);

            },
          ),
        ],
      ),
      body: Obx(
            () => Stack(
          children: [
            GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(22.7196, 75.8577), // Initial map coordinates (San Francisco)
                zoom: 12.0,
              ),
              onMapCreated: (GoogleMapController googleMapController) {
                controller.mapController = googleMapController;
              },
              onTap: (LatLng location) {
                controller.updateSelectedLocation(location);
              },
              markers: controller.selectedLocation.value !=
                  const LatLng(0.0, 0.0)
                  ? {
                Marker(
                  markerId: const MarkerId('selected_location'),
                  position: controller.selectedLocation.value,
                ),
              }
                  : {}, // Place markers only when selectedLocation is not default
            ),
            if (controller.selectedLocation.value != const LatLng(0.0, 0.0))
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    controller.markerInfo.value,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
