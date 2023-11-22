// ignore_for_file: must_be_immutable
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpksmartguide/routes/routes_name.dart';
import 'package:kpksmartguide/theme/custom_text_style.dart';
import 'package:kpksmartguide/theme/theme_helper.dart';
import 'package:kpksmartguide/utils/image_constant.dart';
import 'package:kpksmartguide/utils/size_utils.dart';
import 'package:kpksmartguide/views/home/home_controller.dart';
import 'package:kpksmartguide/views/home/widgets/hotels_item_widget.dart';
import 'package:kpksmartguide/views/home/widgets/martinezcannes_item_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeController controller = Get.put(HomeController());
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        image: DecorationImage(
                          image: AssetImage(ImageConstant.splashImage),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.6), BlendMode.dstATop),
                        ),
                      ),
                      child: Text("KPK TourVista",
                          style: CustomTextStyles.bodyLarge30),
                    ),

                    // places with icon
                    ListTile(
                      leading: Icon(
                        Icons.landscape,
                        color: theme.colorScheme.primary,
                      ),
                      title: Text(
                        "Places to visit",
                        style: CustomTextStyles.titleMediumPrimary16,
                      ),
                      onTap: () {
                        Get.toNamed(RoutesNames.allPlaces,
                            arguments: {"All Places": "All Places"});
                      },
                    ),
                    const Divider(
                      endIndent: 16,
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.hotel,
                        color: theme.colorScheme.primary,
                      ),
                      title: Text("Hotels to stay",
                          style: CustomTextStyles.titleMediumPrimary16),
                      onTap: () {
                        Get.toNamed(RoutesNames.allHotels,
                            arguments: {"All Hotels": "All Hotels"});
                      },
                    ),
                    const Divider(
                      endIndent: 16,
                      height: 1,
                      thickness: 1,
                    ),
                    // Specialities with icon
                    ListTile(
                      leading: Icon(
                        Icons.map_rounded,
                        color: theme.colorScheme.primary,
                      ),
                      title: Text("Specialities",
                          style: CustomTextStyles.titleMediumPrimary16),
                      onTap: () {
                        Get.toNamed(
                          RoutesNames.specialities,
                        );
                      },
                    ),
                    const Divider(
                      endIndent: 16,
                      height: 1,
                      thickness: 1,
                    ),
                    // Malls and Restaurants with icon
                    ListTile(
                      leading: Icon(
                        Icons.restaurant,
                        color: theme.colorScheme.primary,
                      ),
                      title: Text("Malls and Museums",
                          style: CustomTextStyles.titleMediumPrimary16),
                      onTap: () {
                        Get.toNamed(RoutesNames.malls);
                      },
                    ),
                  ],
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.isAdmin.value,
                  child: ListTile(
                    title: const Text("Add Place"),
                    onTap: () {
                      Get.toNamed(RoutesNames.places);
                    },
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.isAdmin.value,
                  child: ListTile(
                    title: const Text("Add Hotel"),
                    onTap: () {
                      Get.toNamed(RoutesNames.hotels);
                    },
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.isAdmin.value,
                  child: ListTile(
                    title: const Text("Add Mall"),
                    onTap: () {
                      Get.toNamed(RoutesNames.addMalls);
                    },
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.isAdmin.value,
                  child: ListTile(
                    title: const Text("Add Speciality"),
                    onTap: () {
                      Get.toNamed(RoutesNames.addSpecialities);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 24.h),
              child: GestureDetector(
                onLongPress: () {
                  controller.isAdmin.value = false;
                  print("Long Pressed");
                },
                onTap: () {
                  // show dailog to enter password
                  Get.defaultDialog(
                    title: "Enter Password",
                    content: TextField(
                      controller: controller.passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                    textConfirm: "Submit",
                    onConfirm: () {
                      if (controller.passwordController.text == "1234") {
                        controller.isAdmin.value = true;
                        //clear the password field
                        controller.passwordController.clear();
                        Get.back();
                      } else {
                        Get.snackbar("Error", "Wrong Password");
                      }
                    },
                  );
                },
                child: Icon(
                  Icons.admin_panel_settings_outlined,
                  color: theme.colorScheme.primary,
                ),
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          title: Text(
            "KPK TourVista",
            style: CustomTextStyles.titleMediumPrimary,
          ),
          elevation: 0,
          // automaticallyImplyLeading: false,
          // leading: Padding(
          //   padding: EdgeInsets.only(left: 24.h),
          //   child: GestureDetector(
          //     onTap: () {
          //       Get.back();
          //     },
          //     child: Icon(
          //       Icons.draw,
          //       color: theme.colorScheme.primary,
          //     ),
          //   ),
          // ),
          // actions: [
          //   Padding(
          //     padding: EdgeInsets.only(right: 24.h),
          //     child: Icon(
          //       Icons.notifications_none,
          //       color: theme.colorScheme.primary,
          //     ),
          //   )
          // ],
        ),
        body: SizedBox(
          width: mediaQueryData.size.width,
          child: Scrollbar(
            interactive: true,
            thumbVisibility: true,
            // trackVisibility: true,
            radius: const Radius.circular(16),
            thickness: 6,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      appTheme.blueGray900,
                      appTheme.cyan900,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30.v),
                    Padding(
                      padding: EdgeInsets.only(right: 24.h, left: 24.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Places to visit".tr,
                              style: theme.textTheme.titleMedium),
                          GestureDetector(
                              onTap: () {
                                Get.toNamed(RoutesNames.allPlaces,
                                    arguments: {"All Places": "All Places"});
                              },
                              child: Text("See All".tr,
                                  style: CustomTextStyles.titleMediumPrimary16))
                        ],
                      ),
                    ),
                    SizedBox(height: 16.v),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(5.h),
                        child: Column(
                          children: [
                            _buildHotels(),
                            SizedBox(height: 34.v),
                            Obx(() => _buildRecentlyBooked()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildHotels() {
    return SizedBox(
        height: 450.v,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('places').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<DocumentSnapshot> places = snapshot.data!.docs;

            return ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(width: 24.h);
              },
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> placeData =
                    places[index].data() as Map<String, dynamic>;
                log(placeData.toString());

                return HotelsItemWidget(
                  name: placeData['name'],
                  description: placeData['description'],
                  address: placeData['address'],
                  images: placeData['images'],
                  speciality: placeData['speciality'],
                );
              },
            );
          },
        ));
  }

  /// Section Widget
  Widget _buildRecentlyBooked() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 24.h, left: 24.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Hotels to stay".tr, style: theme.textTheme.titleMedium),
              GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesNames.allHotels,
                        arguments: {"All Hotels": "All Hotels"});
                  },
                  child: Text("See All".tr,
                      style: CustomTextStyles.titleMediumPrimary16))
            ],
          ),
        ),
        SizedBox(height: 16.v),
        controller.hotels.value.isEmpty
            ? Container(
                padding: EdgeInsets.only(right: 24.h),
                height: 300,
                child: Center(
                  child: Text('No hotels found',
                      style: CustomTextStyles.bodyMediumGray50),
                ),
              )
            : ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 24.v);
                },
                itemCount: controller.hotels.value.length,
                itemBuilder: (context, index) {
                  return MartinezcannesItemWidget(
                    name: controller.hotels.value[index].name,
                    address: controller.hotels.value[index].address,
                    price: controller.hotels.value[index].price,
                    rating: controller.hotels.value[index].rating,
                    images: controller.hotels.value[index].images,
                    placeID: controller.hotels.value[index].placeID,
                    description: controller.hotels.value[index].description,
                  );
                },
              ),
      ],
    );
  }

  /// Navigates to the recentlyBookedScreen when the action is triggered.
  onTapTxtSeeAll() {
    // Get.toNamed(
    //   AppRoutes.recentlyBookedScreen,
    // );
  }
}
