import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpksmartguide/views/places/places_controller.dart';

class PlacesScreen extends StatelessWidget {
  PlacesScreen({super.key});
  PlacesController controller = Get.put(PlacesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: controller.nameController,
              decoration: InputDecoration(labelText: 'Place Name'),
            ),
            TextFormField(
              controller: controller.descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: controller.addressController,
              decoration: InputDecoration(labelText: 'Address'),
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
                await controller.addPlace();
                // DocumentReference documentReference = FirebaseFirestore.instance
                //     .collection('places')
                //     .doc(controller.nameController.text);

                // // Upload images to Firebase Storage
                // final List<String> imageUrls = await controller
                //     .uploadImagesToStorage(controller.selectedImages.value);

                // // create map
                // Map<String, dynamic> places = {
                //   "name": controller.nameController.text,
                //   "description": controller.descriptionController.text,
                //   "address": controller.addressController.text,
                //   "images": imageUrls,
                // };

                // documentReference.set(places).whenComplete(() {
                //   print("${controller.nameController.text} created");
                //   // clear text fields
                //   // controller.nameController.clear();
                //   // controller.descriptionController.clear();
                //   // controller.addressController.clear();
                // });
              },
              child: Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
