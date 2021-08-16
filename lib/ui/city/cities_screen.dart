import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/cities_getx_controller.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/ui/city/city_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CitiesScreen extends StatelessWidget {
  CitiesGetxController controller = Get.put(CitiesGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsetsDirectional.only(
          top: 100.h,
          start: 20.w,
          end: 20.w,
          bottom: 20.h,
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.h),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(0, 10.h),
              color: Colors.black.withOpacity(0.16),
              blurRadius: 18.h,
              spreadRadius: 0,
            ),
          ],
        ),
        child: GetX<CitiesGetxController>(
          builder: (CitiesGetxController controller) {
            return controller.loading.value
                ? Center(child: CircularProgressIndicator())
                : controller.cities.isNotEmpty
                    ? ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: controller.cities.length,
                        itemBuilder: (context, index) {
                          return CityWidget(
                            city: controller.cities[index],
                            onTap: () =>
                                Get.back(result: controller.cities[index]),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 0,
                            color: Colors.grey,
                          );
                        },
                      )
                    : AppTextWidget(content: 'no Data');
          },
        ),
      ),
    );
  }
}
