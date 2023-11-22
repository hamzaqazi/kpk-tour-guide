import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpksmartguide/theme/custom_text_style.dart';
import 'package:kpksmartguide/theme/theme_helper.dart';
import 'package:kpksmartguide/views/specialities/specialities_controller.dart';

class SpecialitiesScreen extends StatelessWidget {
  SpecialityController controller = Get.put(SpecialityController());
  SpecialitiesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Specialities',
          style: CustomTextStyles.titleMediumPrimary,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            ///[appTheme] is defined in [theme_helper.dart]
            colors: [appTheme.blueGray900, appTheme.cyan900],
          ),
        ),
        child: Obx(
          () => controller.specialities.value.isEmpty
              ? Center(
                  child: Text(
                    'No Specialities Found',
                    style: CustomTextStyles.titleLargePrimary,
                  ),
                )
              : Column(
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
                          hintText: 'Search Specialities',
                          hintStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Search by categories',
                            style: CustomTextStyles.bodyLarge25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            '${controller.categories.value.length} categories',
                            style: CustomTextStyles.bodyLarge18,
                          ),
                        ),
                      ],
                    ),
                    // search by category chips
                    Container(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.categories.value.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                controller.searchQuery.value =
                                    controller.categories.value[index];
                              },
                              child: Chip(
                                backgroundColor: Colors.grey[900],
                                label: Text(
                                  controller.categories.value[index],
                                  style: CustomTextStyles.bodyMediumGray50,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Specialities',
                            style: CustomTextStyles.bodyLarge30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            '${controller.specialities.value.length} specialities',
                            style: CustomTextStyles.bodyLarge18,
                          ),
                        ),
                      ],
                    ),

                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.filteredSpecialities
                            .length, // Replace with the actual number of cards you want to display
                        itemBuilder: (context, index) {
                          var speciality =
                              controller.filteredSpecialities[index];
                          return Container(
                            // height: 380,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              // dark color
                              color: Colors.grey[900],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  width: double.infinity,
                                  height: 200,
                                  child: Image.network(
                                    speciality.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // name of the place
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    speciality
                                        .title, // Replace with the actual name of the place
                                    style: CustomTextStyles.titleLarge20,
                                  ),
                                ),

                                // description of the place
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    speciality.description.toString(),
                                    style: CustomTextStyles.bodyMediumGray50,
                                  ),
                                ),
                                // filter chips
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      // filter chip for rating
                                      Chip(
                                        backgroundColor: Colors.grey[900],
                                        label: Text(
                                          speciality.placeID.toString(),
                                          style:
                                              CustomTextStyles.bodyMediumGray50,
                                        ),
                                      ),

                                      // filter chip for price
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
