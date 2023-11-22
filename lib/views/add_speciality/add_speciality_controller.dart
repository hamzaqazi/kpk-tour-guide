import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpksmartguide/views/add_speciality/speciality_model.dart';
import 'package:kpksmartguide/views/places/places_model.dart';
import 'package:kpksmartguide/views/places/places_services.dart';

class AddSpecialityController extends GetxController {
  // text editing controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  Rx<File> selectedImage = Rx<File>(File(''));
  RxString selectedPlace = RxString('');

  List<Place> places = [];
  Rx<List<DropdownMenuItem<String>>> items =
      Rx<List<DropdownMenuItem<String>>>([]);

  @override
  void onInit() async {
    PlacesService placesService = PlacesService();
    places = await placesService.getPlaces();
    items.value = getDropDownMenuItems();
    super.onInit();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    places.forEach((element) {
      items.add(
        DropdownMenuItem(
          child: Text(element.name),
          value: element.name,
        ),
      );
    });

    return items;
  }

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<String> uploadImagesToStorage(File files) async {
    String imageUrl = '';

    final storageReference = FirebaseStorage.instance
        .ref()
        .child('images/specialities${DateTime.now().millisecondsSinceEpoch}');
    final uploadTask = storageReference.putFile(files);
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    imageUrl = downloadUrl;

    return imageUrl;
  }

  Future<void> addSpeciality() async {
    // Upload images to Firebase Storage
    final String imageUrl = await uploadImagesToStorage(selectedImage.value);

    Speciality speciality = Speciality(
      title: nameController.text,
      image: imageUrl,
      placeID: selectedPlace.value,
      description: descriptionController.text,
      category: categoryController.text,
    );

    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('specialities')
        .doc(speciality.title);

    // create map

    documentReference.set(speciality.toMap()).whenComplete(() {
      print("${nameController.text} created");
      // Clear text fields and selected images
      nameController.clear();
      descriptionController.clear();
      selectedImage.value = File('');
      selectedPlace.value = '';
      categoryController.clear();
    });

    // Show a success message or navigate to a new screen
    // ...
  }
}
