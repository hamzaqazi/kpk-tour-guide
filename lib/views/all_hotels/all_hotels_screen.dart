import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpksmartguide/theme/custom_text_style.dart';
import 'package:kpksmartguide/theme/theme_helper.dart';
import 'package:kpksmartguide/views/all_hotels/all_hotels_controller.dart';
import 'package:kpksmartguide/views/widgets/progress_widget.dart';

class AllHotelsScreen extends StatelessWidget {
  AllHotelsController controller = Get.put(AllHotelsController());
  AllHotelsScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Hotels', style: CustomTextStyles.titleMediumPrimary),
      ),
      body: Obx(
        () => ProgressWidget(
          showLoading: controller.isLoading,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,

                ///[appTheme] is defined in [theme_helper.dart]
                colors: [appTheme.blueGray900, appTheme.cyan900],
              ),
            ),
            child: Column(
              children: [
                // search bar to be visible on dark background
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      controller.searchQuery.value = value;
                      // controller.searchPlace(value);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      hintText: 'Search Hotel',
                      hintStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                //Places header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Hotels',
                        style: CustomTextStyles.bodyLarge30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        '${controller.filteredHotels.length} hotels',
                        style: CustomTextStyles.bodyLarge18,
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    trackVisibility: true,
                    radius: const Radius.circular(18.0),
                    child: ListView.builder(
                      itemCount: controller.filteredHotels.length,
                      itemBuilder: (context, index) {
                        var hotel = controller.filteredHotels[index];
                        return _buildListItem(hotel);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(hotel) {
    return Container(
      // decorate card to match dark background of screen
      // color: appTheme.blueGray900,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: appTheme.blueGray900,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: hotel.images.isEmpty
                    ? Container(
                        width: 60.0,
                        height: 60.0,
                        color: Colors.grey, // Placeholder color
                        child: const Icon(Icons.image,
                            color: Colors.white), // Placeholder icon or text
                      )
                    : Image.network(
                        hotel.images[0],
                        width: 60.0,
                        height: 60.0,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // This is the placeholder or alternative widget when the image fails to load
                          return Container(
                            width: 60.0,
                            height: 60.0,
                            color: Colors.grey, // Placeholder color
                            child: const Icon(Icons.image,
                                color:
                                    Colors.white), // Placeholder icon or text
                          );
                        },
                      ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(hotel.name,
                        style: CustomTextStyles.titleLargePrimary),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(hotel.address,
                        style: CustomTextStyles.bodyMediumWhiteA700),
                  ),
                  // Rich text to display price
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Rs. ',
                        style: CustomTextStyles.bodyLarge25,
                        children: [
                          TextSpan(
                            text: '${hotel.price}',
                            style: CustomTextStyles.bodyLarge18,
                          ),
                          TextSpan(
                            text: '/night',
                            style: CustomTextStyles.bodyMediumWhiteA700,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              //  ListTile(
              //   title:
              //       Text(hotel.name, style: CustomTextStyles.titleLargePrimary),
              //   subtitle: Text(hotel.address,
              //       style: CustomTextStyles.bodyMediumWhiteA700),
              //   trailing: Column(
              //     children: [
              //       ElevatedButton(
              //         onPressed: () {
              //           controller.viewHotel(hotel);
              //         },
              //         child: const Text('View'),
              //       ),
              //       Text(
              //         '${hotel.rating}',
              //         style: CustomTextStyles.bodyMediumWhiteA700,
              //       )
              //     ],
              //   ),
              // ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.viewHotel(hotel);
                  },
                  child: const Text('View'),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_border,
                      color: Colors.yellow,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 4.0),
                      child: Text(
                        '${hotel.rating}',
                        style: CustomTextStyles.bodyLarge18,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      // ListTile(
      //   leading: ClipRRect(
      //     borderRadius: BorderRadius.circular(12.0),
      //     child: Image.network(
      //       hotel.images[0],
      //       width: 60.0,
      //       height: 60.0,
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      //   title: Text(hotel.name, style: CustomTextStyles.titleLargePrimary),
      //   subtitle:
      //       Text(hotel.address, style: CustomTextStyles.bodyMediumWhiteA700),
      //   trailing: Column(
      //     children: [
      //       ElevatedButton(
      //         onPressed: () {
      //           controller.viewHotel(hotel);
      //         },
      //         child: const Text('View'),
      //       ),
      //       // rating row with icon and text
      //     ],
      //   ),
      // ),
    );
  }
}
