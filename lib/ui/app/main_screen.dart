import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/user_getx_controller.dart';
import 'package:said_store/model/bottom_navigation_screen.dart';
import 'package:said_store/ui/auth/login_screen.dart';
import 'package:said_store/ui/bn_screen/cart_product_screen.dart';
import 'package:said_store/ui/bn_screen/favorite_products_screen.dart';
import 'package:said_store/ui/bn_screen/home_screen.dart';
import 'package:said_store/ui/bn_screen/profile_settings_screen.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';


class MainScreen extends StatefulWidget {


  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentSelect = 0;
  List<BottomNavigationScreen> screens =  <BottomNavigationScreen>[
    BottomNavigationScreen(title: 'Home', widget: HomeScreen()),
    BottomNavigationScreen(title: 'Cart', widget: CartProductScreen()),
    BottomNavigationScreen(title: 'Favorite', widget: FavoriteProductsScreen()),
    BottomNavigationScreen(title: 'Profile', widget: ProfileSettingsScreen()),
  ];
  @override
  void initState() {
    UsersGetxController.to.initHome();
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
          ],
        ),

        appBar: AppBar(
          title: AppTextWidget(content :screens[_currentSelect].title,),
          actions: [
            IconButton(
              onPressed: () async {
                bool logout = await UsersGetxController.to.logout(context);
                if (logout) {
                  Get.offAll(LoginScreen());
                }
              },
              icon: Icon(Icons.login),
            ),
          ],
        ),
        body: screens[_currentSelect].widget);
  }
}
