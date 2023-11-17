import 'package:flutter/material.dart';
import 'package:kpksmartguide/theme/app_decoration.dart';
import 'package:kpksmartguide/theme/custom_text_style.dart';
import 'package:kpksmartguide/theme/theme_helper.dart';
import 'package:kpksmartguide/utils/image_constant.dart';
import 'package:kpksmartguide/utils/size_utils.dart';
import 'package:kpksmartguide/views/widgets/custom_image_widget.dart';

// ignore: must_be_immutable
class MartinezcannesItemWidget extends StatelessWidget {
  String? name;
  String? address;
  double? price;
  double? rating;
  List<String>? images;

  MartinezcannesItemWidget({
    Key? key,
    this.name,
    this.address,
    this.price,
    this.rating,
    this.images,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18.v),
      decoration: AppDecoration.outlineBlackC.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomImageView(
                imagePath: images?.first ?? ImageConstant.splashImage,
                height: 100.adaptSize,
                width: 100.adaptSize,
                radius: BorderRadius.circular(
                  16.h,
                ),
                margin: EdgeInsets.symmetric(vertical: 1.v),
              ),
              Container(
                width: mediaQueryData.size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name ?? '', style: theme.textTheme.headlineSmall),
                    // SizedBox(height: 18.v),
                    Text(
                      address ?? '',
                      style: theme.textTheme.bodyMedium,
                      overflow: TextOverflow.clip,
                    ),
                    SizedBox(height: 12.v),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.starIcon,
                  height: 12.adaptSize,
                  width: 12.adaptSize,
                  margin: EdgeInsets.symmetric(vertical: 2.v),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Text(
                    '${rating ?? ''}',
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.h,
                    top: 1.v,
                  ),
                  child: Text(
                    '(2,145 Reviews)',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                Spacer(),
                Text(
                  'Rs. ${price ?? ''}',
                  style: CustomTextStyles.headlineSmallPrimary,
                ),
                SizedBox(height: 2.v),
                Text(
                  '/night',
                  style: theme.textTheme.labelLarge,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 8.v,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.h),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        appTheme.blueGray900,
                        appTheme.cyan900,
                      ],
                    ),
                  ),
                  child: Text(
                    'Book Now',
                    style: CustomTextStyles.titleSmallWhiteA700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
