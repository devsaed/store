import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/home_getx_controller.dart';
import 'package:said_store/getx/user_getx_controller.dart';
import 'package:said_store/model/home.dart';
import 'package:said_store/ui/category/category_screen.dart';
import 'package:said_store/ui/category/sub_categoey_screen.dart';
import 'package:said_store/ui/bn_screen/home/home_product.dart';
import 'package:said_store/ui/product/product_details.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/ui/category/category_widget.dart';
import 'package:said_store/ui/bn_screen/home/home_category.dart';
import 'package:said_store/ui/product/product_widget.dart';
import 'package:said_store/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      return controller.isLoading.value ? Center(child: CircularProgressIndicator()):
      controller.home != null ? ListView(
        children: [
          SizedBox(
            height: 400.h,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 400.h,
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
                      height: 400.h,
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
            padding: EdgeInsets.only(top: 25.h, bottom: 10.h, left: 10.w, right: 10.w,),
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
            height: 235.h,
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
            padding: EdgeInsets.only(top: 25.h, bottom: 10.h, left: 10.w, right: 10.w,),
            child: AppTextWidget(content: 'Famous Products'),
          ),
          SizedBox(
            height: 300.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.home!.latestProducts.length,
              itemBuilder: (context, index) {
                return HomeProductWidget(
                    product: controller.home!.latestProducts[index],
                    onTap: () => Get.to(ProductDetailsScreen(productDetails: controller.home!.latestProducts[index]),));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25.h, bottom: 10.h, left: 10.w, right: 10.w,),
            child: AppTextWidget(content: 'Famous Products'),
          ),
          SizedBox(
            height: 300.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.home!.famousProducts.length,
              itemBuilder: (context, index) {
                return HomeProductWidget(
                    product: controller.home!.famousProducts[index],
                    onTap: () => Get.to(ProductDetailsScreen(productDetails: controller.home!.famousProducts[index]),));
              },
            ),
          ),
        ],
      ):Center(child: Text('error'),);
    });
  }
}
