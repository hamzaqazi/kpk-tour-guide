import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpksmartguide/views/hotels/hotels_model.dart';
import 'package:kpksmartguide/views/places/places_model.dart';
import 'package:kpksmartguide/views/places/places_services.dart';
import 'package:kpksmartguide/views/shopping/malls_model.dart';

class AddMallsController extends GetxController {
  // text editing controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  Rx<File> selectedImage = Rx<File>(File(''));

  RxString selectedPlace = RxString('');

  // list of place
  List<Place> places = [];
  Rx<List<DropdownMenuItem<String>>> items =
      Rx<List<DropdownMenuItem<String>>>([]); // list of dropdown menu items

  @override
  void onInit() async {
    PlacesService placesService = PlacesService();
    places = await placesService.getPlaces();
    items.value = getDropDownMenuItems();
    // log(places.toString());
    super.onInit();

    // log(places.toString());
  }

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<String> uploadImagesToStorage(File file) async {
    String imageUrl = '';

    final storageReference = FirebaseStorage.instance
        .ref()
        .child('images/malls/${DateTime.now().millisecondsSinceEpoch}');
    final uploadTask = storageReference.putFile(file);
    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    imageUrl = downloadUrl;

    return imageUrl;
  }

  Future<void> addMall() async {
    // Upload images to Firebase Storage
    final String imageUrl = await uploadImagesToStorage(selectedImage.value);

    MallsModel mall = MallsModel(
      name: nameController.text,
      address: addressController.text,
      image: imageUrl,
      placeID: selectedPlace.value,
      description: descriptionController.text,
    );

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('malls').doc(mall.name);

    // create map

    documentReference.set(mall.toMap()).whenComplete(() {
      print("${nameController.text} created");
      // Clear text fields and selected images
      nameController.clear();
      addressController.clear();
      descriptionController.clear();

      selectedImage.value = File('');
    });

    // Show a success message or navigate to a new screen
    // ...
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
}
