import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpksmartguide/theme/custom_text_style.dart';
import 'package:kpksmartguide/theme/theme_helper.dart';
import 'package:kpksmartguide/views/all_places/all_places_controller.dart';
import 'package:kpksmartguide/views/widgets/progress_widget.dart';

class AllPlacesScreen extends StatelessWidget {
  AllPlacesController controller = Get.put(AllPlacesController());
  AllPlacesScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Places', style: CustomTextStyles.titleMediumPrimary),
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
                      hintText: 'Search Place',
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
                        'Places',
                        style: CustomTextStyles.bodyLarge30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        '${controller.filteredPlaces.length} places',
                        style: CustomTextStyles.bodyLarge18,
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: Scrollbar(
                    interactive: true,
                    thumbVisibility: true,
                    // trackVisibility: true,
                    radius: const Radius.circular(16),
                    thickness: 6,
                    child: ListView.builder(
                      itemCount: controller.filteredPlaces.length,
                      itemBuilder: (context, index) {
                        var place = controller.filteredPlaces[index];
                        return _buildListItem(place);
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

  Widget _buildListItem(place) {
    return Card(
      // decorate card to match dark background of screen
      color: appTheme.blueGray900,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.network(
            place.images[0],
            width: 60.0,
            height: 60.0,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(place.name, style: CustomTextStyles.titleLargePrimary),
        subtitle:
            Text(place.address, style: CustomTextStyles.bodyMediumWhiteA700),
        trailing: ElevatedButton(
          onPressed: () {
            controller.viewPlace(place);
          },
          child: const Text('View'),
        ),
      ),
    );
  }
}
