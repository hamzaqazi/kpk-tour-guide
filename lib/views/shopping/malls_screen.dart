import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpksmartguide/theme/custom_text_style.dart';
import 'package:kpksmartguide/theme/theme_helper.dart';
import 'package:kpksmartguide/views/shopping/malls_controller.dart';

class MallsRestScreen extends StatelessWidget {
  MallsRestController controller = Get.put(MallsRestController());
  MallsRestScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Malls & Museums', style: CustomTextStyles.titleMediumPrimary),
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
          () => controller.malls.value.isEmpty
              ? Center(
                  child: Text(
                    'No Malls & Museums Found',
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
                          hintText: 'Search Malls & Museums',
                          hintStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.filteredMalls
                            .length, // Replace with the actual number of cards you want to display
                        itemBuilder: (context, index) {
                          var mall = controller.malls.value[index];
                          return Container(
                            height: 450,
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
                                    mall.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // name of the place
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    mall.name, // Replace with the actual name of the place
                                    style: CustomTextStyles.titleLarge20,
                                  ),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // description of the place
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    mall.description, // Replace with the actual description text
                                    style: CustomTextStyles.bodyMediumGray50,
                                  ),
                                ),
                                // address section of the mall
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                      ),
                                      Expanded(
                                        child: Text(
                                          mall.address, // Replace with the actual address text
                                          style:
                                              CustomTextStyles.bodyMediumGray50,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
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
                                          mall.placeID.toString(),
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
