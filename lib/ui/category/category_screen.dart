import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/categories_getx_controller.dart';
import 'package:said_store/getx/user_getx_controller.dart';
import 'package:said_store/ui/auth/cities_screen.dart';
import 'package:said_store/ui/auth/forget_password_screen.dart';
import 'package:said_store/ui/auth/login_screen.dart';
import 'package:said_store/ui/category/sub_categoey_screen.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/ui/widgets/category_widget.dart';
import 'package:said_store/utils/app_colors.dart';

class CategoryScreen extends StatelessWidget {
  CategoryGetxController controller = Get.put(CategoryGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'Category',
          color: AppColors.PRIMARY_TEXT_COLOR,
          fontSize: 20,
        ),
      ),
      body: Container(
        child: GetX<CategoryGetxController>(
          builder: (CategoryGetxController controller) {
            return controller.loading.value
                ? Center(child: CircularProgressIndicator())
                : controller.categories.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 29, vertical: 10),
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: controller.categories.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 25,
                            childAspectRatio: 146 / 215,
                            mainAxisSpacing: 40,
                          ),
                          itemBuilder: (context, index) {
                            return CategoryWidget(
                              category: controller.categories[index],
                              onTap: () => Get.to(Get.to(SubCategoryScreen(
                                  id: controller.categories[index].id),),),
                            );
                          },
                        ),
                      )
                    : Center(child: Text('no data'));
          },
        ),
      ),
    );
  }
}
