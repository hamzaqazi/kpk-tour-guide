import 'package:get/get.dart';
import 'package:kpksmartguide/routes/routes_name.dart';
import 'package:kpksmartguide/views/hotels/hotels_model.dart';
import 'package:kpksmartguide/views/hotels/hotels_service.dart';

class AllHotelsController extends GetxController {
  final _allHotels = <Hotel>[].obs;
  final _isLoading = false.obs;

  List<Hotel> get allHotels => _allHotels.toList();
  bool get isLoading => _isLoading.value;
  HotelsService hotelsService = HotelsService();
  RxString hotels = RxString('');
  RxString searchQuery = ''.obs;

  List<Hotel> get filteredHotels {
    if (searchQuery.value.isEmpty) {
      return _allHotels;
    } else {
      return _allHotels
          .where((hotel) =>
              hotel.name
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              hotel.address
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              hotel.price
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              hotel.rating
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  @override
  void onInit() async {
    super.onInit();
    // get arguments
    hotels.value = await Get.arguments['All Hotels'];
    await _loadAllHotels();
  }

  Future<void> _loadAllHotels() async {
    _isLoading.value = true;
    final hotels = await hotelsService.getHotels();
    _allHotels.value = hotels;
    _isLoading.value = false;
  }

  void viewHotel(hotel) {
    Get.offAllNamed(RoutesNames.hotelDetails, arguments: {
      'name': hotel.name,
      'price': hotel.price,
      'images': hotel.images,
      'address': hotel.address,
      'rating': hotel.rating,
      'placeID': hotel.placeID,
      'description': hotel.description,
    });
  }

  // void searchHotel(String value) {
  //   final hotels = _allHotels.where((hotel) {
  //     final nameLower = hotel.name.toLowerCase();
  //     final searchLower = value.toLowerCase();
  //     return nameLower.contains(searchLower);
  //   }).toList();
  //   _allHotels.value = hotels;
  //   _allHotels.refresh();
  // }
}
