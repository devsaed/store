import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/categories_getx_controller.dart';
import 'package:said_store/getx/user_getx_controller.dart';
import 'package:said_store/ui/auth/cities_screen.dart';
import 'package:said_store/ui/auth/forget_password_screen.dart';
import 'package:said_store/ui/auth/login_screen.dart';
import 'package:said_store/ui/category/sub_categoey_screen.dart';
import 'package:said_store/ui/widgets/category_widget.dart';

class CategoryScreen extends StatelessWidget {
  CategoryGetxController controller = Get.put(CategoryGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        ),
        body: Container(
          child: GetX<CategoryGetxController>(
            builder: (CategoryGetxController controller) {
              return controller.categories.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        return CategoryWidget(category: controller.categories[index], onTap: () => Get.to(SubCategoryScreen(id: controller.categories[index].id)));
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
