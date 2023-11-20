import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kpksmartguide/theme/custom_text_style.dart';
import 'package:kpksmartguide/theme/theme_helper.dart';
import 'package:kpksmartguide/utils/size_utils.dart';

import '../utils/image_constant.dart';
import 'widgets/custom_image_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 7), () {
      Navigator.pushNamed(context, '/onBoarding1');
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [appTheme.blueGray900, appTheme.cyan900])),
            child: Column(
              children: [
                CustomImageView(
                    imagePath: ImageConstant.splashImage,
                    height: 420.v,
                    width: 428.h),
                SizedBox(height: 76.v),
                _buildWelcomeSection(),
                SizedBox(height: 5.v)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to",
            style: CustomTextStyles.titleMedium16,
          ),
          SizedBox(height: 23.v),
          Text("KPK TourVista", style: CustomTextStyles.headlineLargePrimary),
          SizedBox(height: 40.v),
          Container(
            width: 319.h,
            margin: EdgeInsets.only(right: 44.v),
            child: Text(
              "KPK TourVista is a mobile application that provides information about tourism in the province of Khyber Pakhtunkhwa.",
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.titleMedium16,
            ),
          ),
        ],
      ),
    );
  }
}
