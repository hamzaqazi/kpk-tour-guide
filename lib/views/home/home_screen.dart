// ignore_for_file: must_be_immutable
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpksmartguide/routes/routes_name.dart';
import 'package:kpksmartguide/theme/custom_text_style.dart';
import 'package:kpksmartguide/theme/theme_helper.dart';
import 'package:kpksmartguide/utils/image_constant.dart';
import 'package:kpksmartguide/utils/size_utils.dart';
import 'package:kpksmartguide/views/home/widgets/hotels_item_widget.dart';
import 'package:kpksmartguide/views/home/widgets/martinezcannes_item_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(children: [
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
              child: Text("KPK Smart Tour Guide",
                  style: CustomTextStyles.bodyLarge18),
            ),
            ListTile(
              title: const Text("Places to Visit"),
              onTap: () {
                Get.toNamed(RoutesNames.places);
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              title: const Text("Hotels to stay"),
              onTap: () {
                Get.toNamed(RoutesNames.hotels);
              },
            ),
          ]),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "KPK Smart Guide",
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
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 24.h),
              child: Icon(
                Icons.notifications_none,
                color: theme.colorScheme.primary,
              ),
            )
          ],
        ),
        body: SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [appTheme.blueGray900, appTheme.cyan900],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30.v),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(left: 24.h),
                      child: Column(
                        children: [
                          _buildHotels(),
                          SizedBox(height: 34.v),
                          _buildRecentlyBooked()
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
    );
  }

  /// Section Widget
  Widget _buildHotels() {
    return SizedBox(
        height: 400.v,
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
          padding: EdgeInsets.only(right: 24.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Hotels To Stay".tr, style: theme.textTheme.titleMedium),
              GestureDetector(
                  onTap: () {
                    onTapTxtSeeAll();
                  },
                  child: Text("See All".tr,
                      style: CustomTextStyles.titleMediumPrimary16))
            ],
          ),
        ),
        SizedBox(height: 16.v),
        Padding(
          padding: EdgeInsets.only(right: 24.h),
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 24.v);
            },
            itemCount: 4,
            itemBuilder: (context, index) {
              return MartinezcannesItemWidget();
            },
          ),
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
