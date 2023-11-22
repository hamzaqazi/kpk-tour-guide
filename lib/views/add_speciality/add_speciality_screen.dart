import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpksmartguide/theme/custom_text_style.dart';
import 'package:kpksmartguide/theme/theme_helper.dart';
import 'package:kpksmartguide/views/add_speciality/add_speciality_controller.dart';
import 'package:kpksmartguide/views/places/places_controller.dart';

class AddSpecialityScreen extends StatelessWidget {
  AddSpecialityScreen({super.key});
  AddSpecialityController controller = Get.put(AddSpecialityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Add Speciality', style: CustomTextStyles.titleMediumPrimary),
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
                    hintText: 'Enter Speciality',
                    hintStyle: const TextStyle(color: Colors.white),
                    label: const Text('Speciality'),
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                // category text field
                TextField(
                  controller: controller.categoryController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    hintText: 'Enter Category',
                    hintStyle: const TextStyle(color: Colors.white),
                    label: const Text('Category'),
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    hintText: 'Enter Description',
                    hintStyle: const TextStyle(color: Colors.white),
                    label: const Text('Description'),
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 20),
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
                  child: const Text('Pick Image for speciality'),
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
                // Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    await controller.addSpeciality();
                  },
                  child: const Text('Add Speciality'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
