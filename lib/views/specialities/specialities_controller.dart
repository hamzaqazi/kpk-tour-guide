import 'dart:developer';

import 'package:get/get.dart';
import 'package:kpksmartguide/views/add_speciality/speciality_model.dart';
import 'package:kpksmartguide/views/add_speciality/speciality_service.dart';

class SpecialityController extends GetxController {
  // Add your controller logic here

  SpecialityService specialityService = SpecialityService();
  RxString searchQuery = ''.obs;
  // list of malls
  Rx<List<Speciality>> specialities = Rx<List<Speciality>>([]);
  // list of Strings of categories
  Rx<List<String>> categories = Rx<List<String>>([]);

  List<Speciality> get filteredSpecialities {
    if (searchQuery.value.isEmpty) {
      return specialities.value;
    } else {
      return specialities.value
          .where((speciality) =>
              speciality.title
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              speciality.placeID
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              speciality.category!
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  @override
  void onInit() async {
    // get malls
    specialities.value = await specialityService.getSpecialities();
    if (specialities.value.isNotEmpty) {
      // get categories
      specialities.value.forEach((element) {
        categories.value.add(element.category!);
      });
      log(categories.value.toString());
      // remove duplicates
      categories.value = categories.value.toSet().toList();
      log(categories.value.toString());
    }
    // log(specialities.value.toString());
    super.onInit();
  }
}
