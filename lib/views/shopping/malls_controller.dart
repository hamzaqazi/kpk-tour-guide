import 'dart:developer';

import 'package:get/get.dart';
import 'package:kpksmartguide/views/shopping/malls_model.dart';
import 'package:kpksmartguide/views/shopping/malls_services.dart';

class MallsRestController extends GetxController {
  // Add your controller logic here

  MallsService mallsService = MallsService();
  RxString searchQuery = ''.obs;
  // list of malls
  Rx<List<MallsModel>> malls = Rx<List<MallsModel>>([]);

  List<MallsModel> get filteredMalls {
    if (searchQuery.value.isEmpty) {
      return malls.value;
    } else {
      return malls.value
          .where((hotel) => hotel.name
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  @override
  void onInit() async {
    // get malls
    malls.value = await mallsService.getMalls();
    log(malls.value.toString());
    super.onInit();
  }
}
