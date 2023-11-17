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

class HotelsController extends GetxController {
  // text editing controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  Rx<List<File>> selectedImages = Rx<List<File>>([]);

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
    log(places.toString());
    super.onInit();

    // log(places.toString());
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
          .child('images/hotels/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = storageReference.putFile(file);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }

    return imageUrls;
  }

  Future<void> addHotel() async {
    // Upload images to Firebase Storage
    final List<String> imageUrls =
        await uploadImagesToStorage(selectedImages.value);

    Hotel hotel = Hotel(
      name: nameController.text,
      price: double.parse(priceController.text),
      rating: double.parse(ratingController.text),
      address: addressController.text,
      images: imageUrls,
      placeID: selectedPlace.value,
    );

    if (hotel.name.isEmpty ||
        hotel.price.toString().isEmpty ||
        hotel.address.isEmpty) {
      // Handle empty fields
      return;
    }

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('hotels').doc(hotel.name);

    // create map

    documentReference.set(hotel.toMap()).whenComplete(() {
      print("${nameController.text} created");
      // Clear text fields and selected images
      nameController.clear();
      priceController.clear();
      addressController.clear();

      selectedImages.value = [];
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
