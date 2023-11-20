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
                  .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  @override
  void onInit() async {
    // get malls
    specialities.value = await specialityService.getSpecialities();
    log(specialities.value.toString());
    super.onInit();
  }
}
