import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpksmartguide/views/places/places_model.dart';

class PlacesController extends GetxController {
  // text editing controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  Rx<List<File>> selectedImages = Rx<List<File>>([]);

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      selectedImages.value =
          pickedFiles.map((file) => File(file.path)).toList();
    }
  }

  Future<List<String>> uploadImagesToStorage(List<File> files) async {
    final List<String> imageUrls = [];

    for (File file in files) {
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = storageReference.putFile(file);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }

    return imageUrls;
  }

  Future<void> addPlace() async {
    // Upload images to Firebase Storage
    final List<String> imageUrls =
        await uploadImagesToStorage(selectedImages.value);

    Place place = Place(
      name: nameController.text,
      description: descriptionController.text,
      address: addressController.text,
      images: imageUrls,
    );

    if (place.name.isEmpty ||
        place.description.isEmpty ||
        place.address.isEmpty) {
      // Handle empty fields
      return;
    }

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('places').doc(place.name);

    // create map

    documentReference.set(place.toMap()).whenComplete(() {
      print("${nameController.text} created");
      // Clear text fields and selected images
      nameController.clear();
      descriptionController.clear();
      addressController.clear();

      selectedImages.value = [];
    });

    // Show a success message or navigate to a new screen
    // ...
  }
}
