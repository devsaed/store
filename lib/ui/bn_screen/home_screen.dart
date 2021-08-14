import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/home_getx_controller.dart';
import 'package:said_store/getx/user_getx_controller.dart';
import 'package:said_store/model/Home.dart';
import 'package:said_store/model/product.dart';
import 'package:said_store/ui/category/category_screen.dart';
import 'package:said_store/ui/category/sub_categoey_screen.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/ui/widgets/category_widget.dart';
import 'package:said_store/ui/widgets/home_category.dart';
import 'package:said_store/ui/widgets/home_product.dart';
import 'package:said_store/ui/widgets/product_widget.dart';
import 'package:said_store/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeGetxController controller = Get.put(HomeGetxController());
  UsersGetxController usersController = Get.put(UsersGetxController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeGetxController>(builder: (HomeGetxController controller){
      return controller.isLoading ? Center(child: CircularProgressIndicator()):
      ListView(
        children: [
          SizedBox(
            height: 400,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 400,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: controller.home!.slider.map((MySlider slider) {
                return Builder(
                  builder: (BuildContext context) {
                    return CachedNetworkImage(
                      height: 400,
                      width: double.infinity,
                      imageUrl: slider.imageUrl,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: AppColors.PRIMARY_COLOR,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25, bottom: 10, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextWidget(content: 'Category'),
                GestureDetector(
                  child: AppTextWidget(content: 'See More'),
                  onTap: () => Get.to(CategoryScreen()),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 235,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return HomeCategoryWidget(
                  category: controller.home!.categories[index],
                  onTap: () => Get.to(SubCategoryScreen(
                      id: controller.home!.categories[index].id)),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25, bottom: 10, left: 10, right: 10),
            child: AppTextWidget(content: 'Famous Products'),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.home!.latestProducts.length,
              itemBuilder: (context, index) {
                return HomeProductWidget(
                    product: controller.home!.latestProducts[index],
                    onTap: () {});
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25, bottom: 10, left: 10, right: 10),
            child: AppTextWidget(content: 'Famous Products'),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.home!.famousProducts.length,
              itemBuilder: (context, index) {
                return HomeProductWidget(
                    product: controller.home!.famousProducts[index],
                    onTap: () {});
              },
            ),
          ),
        ],
      );
    });
  }
}
