import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:kpksmartguide/theme/custom_text_style.dart';
import 'package:kpksmartguide/views/add_malls/add_malls_controller.dart';
import 'package:kpksmartguide/views/hotels/hotels_controller.dart';
import 'package:kpksmartguide/views/places/places_controller.dart';

import '../../theme/theme_helper.dart';

class AddMallsScreen extends StatelessWidget {
  AddMallsScreen({super.key});
  AddMallsController controller = Get.put(AddMallsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Mall & Restourant',
            style: CustomTextStyles.titleMediumPrimary),
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
                //description text field
                TextField(
                  controller: controller.descriptionController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    labelText: 'Description',
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
                  child: const Text('Pick Image for mall'),
                ),
                // place selected images here in a small grid
                Obx(
                  () => controller.selectedImage.value.path.isEmpty
                      ? Container()
                      : Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            image: DecorationImage(
                              image: FileImage(controller.selectedImage.value),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
                // const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    await controller.addMall();
                  },
                  child: const Text('Add Mall'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
