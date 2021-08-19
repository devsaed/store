import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/fb_notifications/fb_notifications.dart';
import 'package:said_store/getx/user_getx_controller.dart';
import 'package:said_store/model/bottom_navigation_screen.dart';
import 'package:said_store/ui/auth/login_screen.dart';
import 'package:said_store/ui/bn_screen/cart/cart_product_screen.dart';
import 'package:said_store/ui/bn_screen/favorite/favorite_products_screen.dart';
import 'package:said_store/ui/bn_screen/home/home_screen.dart';
import 'package:said_store/ui/bn_screen/order/show_all_order_screen.dart';
import 'package:said_store/ui/bn_screen/profile/profile_settings_screen.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MainScreen extends StatefulWidget {


  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with FbNotifications{

  int _currentSelect = 0;
  List<BottomNavigationScreen> screens =  <BottomNavigationScreen>[
    BottomNavigationScreen(title: 'Home', widget: HomeScreen()),
    BottomNavigationScreen(title: 'Cart', widget: CartProductScreen()),
    BottomNavigationScreen(title: 'Favorite', widget: FavoriteProductsScreen()),
    BottomNavigationScreen(title: 'Profile', widget: ProfileSettingsScreen()),
    BottomNavigationScreen(title: 'Order', widget: ShowAllOrdersScreen()),
  ];
  @override
  void initState() {
    UsersGetxController.to.initHome();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentSelect,
          onTap: (selectItem) {
            setState(() {
              _currentSelect = selectItem;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
           BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outlined),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Orders',
            ),
          ],
        ),

        appBar: AppBar(
          centerTitle: true,
          title: AppTextWidget(
            content: screens[_currentSelect].title,
            color: AppColors.PRIMARY_TEXT_COLOR,
            fontSize: 20.sp,
          ),
        ),
        body: screens[_currentSelect].widget);
  }
}
