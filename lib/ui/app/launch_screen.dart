import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/cart_getx_controller.dart';
import 'package:said_store/getx/cities_getx_controller.dart';
import 'package:said_store/getx/order_getx_controller.dart';
import 'package:said_store/getx/product_getx_controller.dart';
import 'package:said_store/local_storge/shared_preferences/preferences.dart';
import 'package:said_store/ui/app/main_screen.dart';

import 'package:said_store/ui/on_boarding/on_boarding_screen.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/utils/app_colors.dart';

import '../../getx/user_getx_controller.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  UsersGetxController usersController = Get.put(UsersGetxController());
  ProductGetxController controller = Get.put(ProductGetxController());
  CartGetxController cartGetxController = Get.put(CartGetxController());
  OrderGetxController orderGetxController = Get.put(OrderGetxController());
  CitiesGetxController citiesGetxController = Get.put(CitiesGetxController());


  @override
  void initState() {
    Widget route = SharedPreferencesController().loggedIn
        ? MainScreen()
        : OnBoardingScreen();
    Future.delayed(Duration(seconds: 3), () => Get.off(route));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/svg/logo.svg',
              height: 83.h,
              width: 61.21.w,
            ),
            SizedBox(height: 26.h),
            AppTextWidget(
              content: 'Omumu\'s',
              color: Colors.white,
              fontFamily: 'spartan',
              fontSize: 36.sp,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
