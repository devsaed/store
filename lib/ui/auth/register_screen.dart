import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/user_getx_controller.dart';
import 'package:said_store/local_storge/shared_preferences/preferences.dart';
import 'package:said_store/model/city.dart';
import 'package:said_store/ui/auth/activation_account_screen.dart';
import 'package:said_store/ui/auth/cities_screen.dart';
import 'package:said_store/ui/widgets/app_elevated_button.dart';
import 'package:said_store/ui/widgets/app_text_field.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/utils/app_colors.dart';
import 'package:said_store/utils/helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;
  City? city;
  bool isMale = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'Register',
          color: AppColors.PRIMARY_TEXT_COLOR,
          fontSize: 20.sp,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(32.h),
        children: [
          SizedBox(height: 30.h),
          SvgPicture.asset(
            'assets/svg/logo_blue.svg',
            height: 83.h,
            width: 61.21.h,
          ),
          SizedBox(height: 80.h),
          AppTextField(
            controller: nameController,
            label: 'Name',
            suffix: Icon(
              Icons.person,
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
          SizedBox(height: 20.h),
          AppTextField(
            controller: passwordController,
            label: 'Password',
            isPassword: true,
            suffix: Icon(
              Icons.lock,
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
          SizedBox(height: 20.h),
          AppTextField(
            controller: phoneController,
            label: 'Phone Number',
            prefix: AppTextWidget(content: '0', fontSize: 16),
            suffix: Icon(
              Icons.phone_android_outlined,
              color: AppColors.PRIMARY_COLOR,
            ),
            textInputType: TextInputType.phone,
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: () async {
              City selectedCity = await Get.to(CitiesScreen());
              setState(() {
                city = selectedCity;
              });
            },
            child: Container(
                padding: EdgeInsetsDirectional.only(start: 28.w, end: 10),
                alignment: AlignmentDirectional.centerStart,
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF999999).withAlpha(25),
                        offset: Offset(0, 5.h),
                        blurRadius: 10.h,
                        spreadRadius: 0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(25.h),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  children: [
                    getCityName(),
                    Spacer(),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: AppColors.PRIMARY_COLOR,
                    )
                  ],
                )),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  checkColor: Colors.white,
                  activeColor: AppColors.PRIMARY_COLOR,
                  value: isMale,
                  onChanged: (var selected) {
                    setState(() {
                      isMale = true;
                    });
                  },
                  title: AppTextWidget(
                    content: 'Male',
                    fontSize: 16,
                    color: AppColors.PRIMARY_TEXT_COLOR,
                  ),
                ),
              ),
              VerticalDivider(
                color: Colors.red,
                width: 50,
                thickness: 5,
              ),
              Expanded(
                child: CheckboxListTile(
                  checkColor: Colors.white,
                  activeColor: AppColors.PRIMARY_COLOR,
                  value: !isMale,
                  onChanged: (var selected) {
                    setState(() {
                      isMale = false;
                    });
                  },
                  title: AppTextWidget(
                    content: 'Female',
                    fontSize: 16,
                    color: AppColors.PRIMARY_TEXT_COLOR,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 42),
          AppElevatedButton(
            text: 'Register',
            onPressed: () async {
              await performRegister();
            },
          ),
        ],
      ),
    );
  }

  Widget getCityName() {
    if (city == null) {
      return AppTextWidget(
        content: 'Select City',
        color: Colors.grey,
      );
    } else {
      if (SharedPreferencesController().languageCode == 'ar') {
        return AppTextWidget(
          content: city!.nameAr,
          color: AppColors.PRIMARY_TEXT_COLOR,
          fontSize: 16,
        );
      } else {
        return AppTextWidget(
          content: city!.nameEn,
          color: AppColors.PRIMARY_TEXT_COLOR,
          fontSize: 16,
        );
      }
    }
  }

  Future<void> performRegister() async {
    if (checkData()) {
      await register();
    }
  }

  bool checkData() {
    if (nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        city != null) {
      return true;
    }
    return false;
  }

  Future<void> register() async {
    int? code = await UsersGetxController.to.register(
        context: context,
        name: nameController.text,
        mobile: phoneController.text,
        password: passwordController.text,
        gender: isMale ? 'M' : 'F',
        city: city!.id);
    if (code != null) {
      Helper.showSnackBar(context, text: code.toString(), error: true);
      Get.off(ActivationScreen(mobile: phoneController.text));
    }
  }
}
