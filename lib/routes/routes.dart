import 'package:get/get.dart';
import 'package:kpksmartguide/routes/routes_name.dart';
import 'package:kpksmartguide/views/add_malls/add_malls_screen.dart';
import 'package:kpksmartguide/views/add_speciality/add_speciality_screen.dart';
import 'package:kpksmartguide/views/all_hotels/all_hotels_screen.dart';
import 'package:kpksmartguide/views/all_places/all_places_screen.dart';
import 'package:kpksmartguide/views/home/home_screen.dart';
import 'package:kpksmartguide/views/hotel_details/hotel_details_screen.dart';
import 'package:kpksmartguide/views/hotels/hotels_screen.dart';
import 'package:kpksmartguide/views/onboarding_one_screen/onboarding_one_screen.dart';
import 'package:kpksmartguide/views/onboarding_three_screen/onboarding_three_screen.dart';
import 'package:kpksmartguide/views/onboarding_two_screen/onboarding_two_screen.dart';
import 'package:kpksmartguide/views/place_details/place_details_screen.dart';
import 'package:kpksmartguide/views/places/places_screen.dart';
import 'package:kpksmartguide/views/shopping/malls_screen.dart';
import 'package:kpksmartguide/views/specialities/specialities_screen.dart';
import 'package:kpksmartguide/views/splash_screen.dart';

class AppRoutes {
  static const INITIAL = RoutesNames.splash;
  static final routes = [
    GetPage(name: RoutesNames.splash, page: () => SplashPage()),
    GetPage(name: RoutesNames.login, page: () => SplashPage()),
    GetPage(name: RoutesNames.home, page: () => HomeScreen()),
    GetPage(name: RoutesNames.onBoarding1, page: () => OnboardingOneScreen()),
    GetPage(name: RoutesNames.onBoarding2, page: () => OnboardingTwoScreen()),
    GetPage(name: RoutesNames.onBoarding3, page: () => OnboardingThreeScreen()),
    GetPage(name: RoutesNames.places, page: () => PlacesScreen()),
    GetPage(name: RoutesNames.placeDetails, page: () => PlaceDetailsScreen()),
    GetPage(name: RoutesNames.allPlaces, page: () => AllPlacesScreen()),
    GetPage(name: RoutesNames.allHotels, page: () => AllHotelsScreen()),
    GetPage(name: RoutesNames.hotelDetails, page: () => HotelDetailsScreen()),
    GetPage(name: RoutesNames.hotels, page: () => HotelsScreen()),
    GetPage(name: RoutesNames.malls, page: () => MallsRestScreen()),
    GetPage(name: RoutesNames.addMalls, page: () => AddMallsScreen()),
    GetPage(
        name: RoutesNames.addSpecialities, page: () => AddSpecialityScreen()),
    GetPage(name: RoutesNames.specialities, page: () => SpecialitiesScreen()),
  ];
}
