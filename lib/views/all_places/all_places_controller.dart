import 'package:get/get.dart';
import 'package:kpksmartguide/routes/routes_name.dart';
import 'package:kpksmartguide/views/places/places_model.dart';
import 'package:kpksmartguide/views/places/places_services.dart';

class AllPlacesController extends GetxController {
  final _allPlaces = <Place>[].obs;
  final _isLoading = false.obs;

  List<Place> get allPlaces => _allPlaces.toList();
  bool get isLoading => _isLoading.value;
  PlacesService placesService = PlacesService();
  RxString places = RxString('');
  RxString searchQuery = ''.obs;

  List<Place> get filteredPlaces {
    if (searchQuery.value.isEmpty) {
      return _allPlaces;
    } else {
      return _allPlaces
          .where((place) => place.name
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    // get arguments
    places.value = await Get.arguments['All Places'];
    await _loadAllPlaces();
  }

  Future<void> _loadAllPlaces() async {
    _isLoading.value = true;
    final places = await placesService.getPlaces();
    _allPlaces.value = places;
    _isLoading.value = false;
  }

  void viewPlace(place) {
    Get.toNamed(RoutesNames.placeDetails, arguments: {
      'name': place.name,
      'description': place.description,
      'images': place.images,
      'address': place.address,
    });
  }

  // void searchPlace(String value) {
  //   final places = _allPlaces.where((place) {
  //     final nameLower = place.name.toLowerCase();
  //     final searchLower = value.toLowerCase();
  //     return nameLower.contains(searchLower);
  //   }).toList();
  //   _allPlaces.value = places;
  //   _allPlaces.refresh();
  // }
}
