import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/cities_getx_controller.dart';
import 'package:said_store/ui/widgets/city_widget.dart';

class CitiesScreen extends StatelessWidget {
  CitiesGetxController controller = Get.put(CitiesGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsetsDirectional.only(
            top: 100, start: 20, end: 20, bottom: 20),
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(0, 10),
              color: Colors.black.withOpacity(0.16),
              blurRadius: 18,
              spreadRadius: 0,
            ),
          ],
        ),
        child: GetX<CitiesGetxController>(
          builder: (CitiesGetxController controller) {
            return controller.cities.isEmpty
                ? Center(child: CircularProgressIndicator(),)
                : ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: controller.cities.length,
                    itemBuilder: (context, index) {
                      return CityWidget(
                        city: controller.cities[index],
                        onTap: () => Get.back(result: controller.cities[index]),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 0,
                        color: Colors.grey,
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
