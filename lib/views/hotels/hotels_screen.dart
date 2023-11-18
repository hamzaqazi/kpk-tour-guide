import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:kpksmartguide/theme/custom_text_style.dart';
import 'package:kpksmartguide/views/hotels/hotels_controller.dart';
import 'package:kpksmartguide/views/places/places_controller.dart';

import '../../theme/theme_helper.dart';

class HotelsScreen extends StatelessWidget {
  HotelsScreen({super.key});
  HotelsController controller = Get.put(HotelsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Hotel', style: CustomTextStyles.titleMediumPrimary),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [appTheme.blueGray900, appTheme.cyan900],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: controller.nameController,
                  // light color text will be visible on dark background
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    labelText: 'Name',
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller.addressController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    labelText: 'Address',
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),

                TextField(
                  controller: controller.priceController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    labelText: 'Price',
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller.ratingController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    labelText: 'Rating',
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),

                // Drop down for selecting place
                Obx(
                  () => DropdownButton(
                    hint: const Text(
                      'Select Place',
                      style: TextStyle(color: Colors.white),
                    ),
                    items: controller.items.value,
                    value: controller.selectedPlace.value.isEmpty
                        ? null
                        : controller.selectedPlace.value,
                    onChanged: (value) {
                      controller.selectedPlace.value = value.toString();
                    },
                  ),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.pickImages();
                  },
                  child: const Text('Pick Images for hotel'),
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
                                margin: const EdgeInsets.all(3),
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
                // const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    await controller.addHotel();
                  },
                  child: const Text('Add Hotel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
