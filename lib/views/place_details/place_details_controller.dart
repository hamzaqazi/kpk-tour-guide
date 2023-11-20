import 'dart:developer';

import 'package:get/get.dart';
import 'package:kpksmartguide/views/add_speciality/speciality_model.dart';
import 'package:kpksmartguide/views/add_speciality/speciality_service.dart';
import 'package:kpksmartguide/views/hotels/hotels_model.dart';
import 'package:kpksmartguide/views/hotels/hotels_service.dart';
import 'package:kpksmartguide/views/shopping/malls_model.dart';
import 'package:kpksmartguide/views/shopping/malls_services.dart';

class PlaceDetailsController extends GetxController {
  // variables
  RxString name = ''.obs;
  RxString description = ''.obs;
  RxList images = [].obs;
  RxString address = ''.obs;
  Rx<List<Hotel>> filteredHotels = Rx<List<Hotel>>([]);
  Rx<List<Hotel>> hotels = Rx<List<Hotel>>([]);
  RxString speciality = ''.obs;
  SpecialityService specialityService = SpecialityService();
  MallsService mallsService = MallsService();
  // list of specialities
  Rx<List<Speciality>> specialities = Rx<List<Speciality>>([]);
  // filtered specialities list empty
  Rx<List<Speciality>> matchSpecialities = Rx<List<Speciality>>([]);
  // list of malls
  Rx<List<MallsModel>> malls = Rx<List<MallsModel>>([]);
  // filtered malls list empty
  Rx<List<MallsModel>> matchMalls = Rx<List<MallsModel>>([]);

  @override
  void onInit() async {
    super.onInit();
    // Get the arguments
    name.value = Get.arguments['name'];
    description.value = Get.arguments['description'];
    images.value = Get.arguments['images'];
    address.value = Get.arguments['address'];
    // speciality.value = Get.arguments['speciality'];

    HotelsService hotelsService = HotelsService();
    hotels.value = await hotelsService.getHotels();
    if (name.value.isNotEmpty) {
      filteredHotels.value = hotels.value
          .where((element) => element.placeID == name.value)
          .toList();
    }

    if (name.value.isNotEmpty) {
      specialities.value = await specialityService.getSpecialities();
      matchSpecialities.value = specialities.value
          .where((element) => element.placeID == name.value)
          .toList();
    }

    if (name.value.isNotEmpty) {
      malls.value = await mallsService.getMalls();
      matchMalls.value = malls.value
          .where((element) => element.placeID == name.value)
          .toList();
    }

    log(filteredHotels.toString());
  }
}
