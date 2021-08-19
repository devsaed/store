import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/user_getx_controller.dart';
import 'package:said_store/locale/app_locale.dart';
import 'package:said_store/ui/address/address_screen.dart';
import 'package:said_store/ui/auth/change_password_screen.dart';
import 'package:said_store/ui/auth/login_screen.dart';
import 'package:said_store/ui/auth/profile_screen.dart';
import 'package:said_store/ui/contact/contact_us_screen.dart';
import 'package:said_store/ui/credit_card/display_cards_screen.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/ui/bn_screen/profile/profile_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 25.h, bottom: 15.h),
            child: AppTextWidget(
              content: 'general',
              color: Colors.black,
              fontSize: 15.sp,
              textAlign: TextAlign.center,
            ),
          ),
          ProfileWidget(
            label: 'contact us',
            leading: Icon(Icons.info),
            trailingIcon: Icons.arrow_forward_ios,
            onTap: ()=> Get.to(ContactUsScreen()),
          ),
          ProfileWidget(
            label: 'My Cards',
            leading: Icon(Icons.money),
            trailingIcon: Icons.arrow_forward_ios,
            onTap: () => Get.to(DisplayCardScreen()),
          ),

          ProfileWidget(
            label: 'My Address',
            leading: Icon(Icons.location_on),
            trailingIcon: Icons.arrow_forward_ios,
            onTap: () => Get.to(AddressScreen()),
          ),

          ProfileWidget(
            label: 'language',
            leading: Icon(Icons.language_outlined),
            trailingIcon: Icons.arrow_forward_ios,
            onTap: () => AppLocale.changeLang(),
          ),
          ProfileWidget(
            label: 'change password',
            leading: Icon(Icons.refresh),
            onTap: ()=> Get.to(ChangePasswordScreen()),
          ),
          ProfileWidget(
            label: 'edit- profile',
            leading: Icon(Icons.person),
            onTap: () =>Get.to(ProfileScreen())
          ),
          ProfileWidget(
            label: 'logout',
            leading: Icon(Icons.logout),
            onTap: () async {
              bool logout = await UsersGetxController.to.logout(context);
              if (logout) {
                Get.offAll(LoginScreen());
              }
            }
          ),
        ],
      ),
    );
  }
}
