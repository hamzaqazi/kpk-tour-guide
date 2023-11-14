import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:kpksmartguide/views/hotels/hotels_controller.dart';
import 'package:kpksmartguide/views/places/places_controller.dart';

class HotelsScreen extends StatelessWidget {
  HotelsScreen({super.key});
  HotelsController controller = Get.put(HotelsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Hotel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: controller.nameController,
              decoration: InputDecoration(labelText: 'Hotel Name'),
            ),
            TextFormField(
              controller: controller.addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextFormField(
              controller: controller.priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),

            // Drop down for selecting place
            Obx(
              () => DropdownButton(
                hint: Text('Select Place'),
                value: controller.selectedPlace.value.isEmpty
                    ? null
                    : controller.selectedPlace.value,
                onChanged: (value) {
                  controller.selectedPlace.value = value.toString();
                },
                items: controller.getDropDownMenuItems(),
              ),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.pickImages();
              },
              child: Text('Pick Images'),
            ),
            // place selected images here in a small grid
            Obx(
              () => controller.selectedImages.value.isEmpty
                  ? Container()
                  : GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      children: List.generate(
                        controller.selectedImages.value.length,
                        (index) {
                          return Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(
                                  controller.selectedImages.value[index],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                await controller.addHotel();
              },
              child: Text('Add Hotel'),
            ),
          ],
        ),
      ),
    );
  }
}
