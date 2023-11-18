import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpksmartguide/theme/custom_text_style.dart';
import 'package:kpksmartguide/theme/theme_helper.dart';
import 'package:kpksmartguide/views/places/places_controller.dart';

class PlacesScreen extends StatelessWidget {
  PlacesScreen({super.key});
  PlacesController controller = Get.put(PlacesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Place', style: CustomTextStyles.titleMediumPrimary),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [appTheme.blueGray900, appTheme.cyan900],
              // colors: [Colors.blueGrey, Colors.cyan],
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: controller.nameController,
                  // light color text will be visible on dark background
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    hintText: 'Enter Place Name',
                    hintStyle: const TextStyle(color: Colors.white),
                    label: const Text('Name'),
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller.descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    hintText: 'Enter Place Description',
                    hintStyle: const TextStyle(color: Colors.white),
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    hintText: 'Enter Place Address',
                    hintStyle: const TextStyle(color: Colors.white),
                    labelText: 'Address',
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    controller.pickImages();
                  },
                  child: const Text('Pick Images for Place'),
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
                // Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    await controller.addPlace();
                  },
                  child: Text('Add Place'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
