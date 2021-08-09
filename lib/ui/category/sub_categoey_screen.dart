import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/categories_getx_controller.dart';
import 'package:said_store/ui/product/product_screen.dart';
import 'package:said_store/ui/widgets/sub_category_widget.dart';

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
    controller.getSubCategories(id: widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: GetX<CategoryGetxController>(
          builder: (CategoryGetxController controller) {
            return controller.subCategories.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: controller.subCategories.length,
                    itemBuilder: (context, index) {
                      return SubCategoryWidget(
                          subCategory: controller.subCategories[index],
                          onTap: () => Get.to(ProductScreen(id: controller.subCategories[index].id)));
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
