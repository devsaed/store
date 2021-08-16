import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/categories_getx_controller.dart';
import 'package:said_store/ui/product/product_screen.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/ui/category/sub_category_widget.dart';
import 'package:said_store/utils/app_colors.dart';

class SubCategoryScreen extends StatefulWidget {
  final int id;

  SubCategoryScreen({required this.id});

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  CategoryGetxController controller = Get.put(CategoryGetxController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await controller.getSubCategories(id: widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'Sub Category',
          color: AppColors.PRIMARY_TEXT_COLOR,
          fontSize: 20,
        ),
      ),
      body: Container(
        child: GetX<CategoryGetxController>(
          builder: (CategoryGetxController controller) {
            return controller.loading.value
                ? Center(child: CircularProgressIndicator())
                : controller.subCategories.isNotEmpty?
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 29, vertical: 10),
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: controller.subCategories.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 25,
                  childAspectRatio: 146 / 215,
                  mainAxisSpacing: 40,
                ),
                itemBuilder: (context, index) {
                  return SubCategoryWidget(
                      subCategory: controller.subCategories[index],
                      onTap: () => Get.to(ProductScreen(
                          id: controller.subCategories[index].id)));
                },
              ),
            ):Center(child: Text('no data'));
          },
        ),
      ),
    );
  }
}
