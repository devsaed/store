import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:said_store/ui/app/main_screen.dart';
import 'package:said_store/ui/auth/forget_password_screen.dart';
import 'package:said_store/ui/auth/register_screen.dart';
import 'package:said_store/ui/category/category_screen.dart';
import 'package:said_store/getx/user_getx_controller.dart';
import 'package:said_store/ui/widgets/app_elevated_button.dart';
import 'package:said_store/ui/widgets/app_text_field.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/utils/app_colors.dart';
import 'package:said_store/utils/helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController phoneEditingController;
  late TextEditingController passwordEditingController;
  late TapGestureRecognizer recognizer;

  @override
  void initState() {
    super.initState();
    phoneEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    recognizer = TapGestureRecognizer();
    recognizer.onTap = navigateToCreateAccountScreen;
  }

  @override
  void dispose() {
    phoneEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  navigateToCreateAccountScreen() {
    Get.to(RegisterScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'Login',
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
            width: 61.21.w,
          ),
          SizedBox(height: 80.h),
          AppTextField(
            controller: phoneEditingController,
            label: 'Phone Number',
            prefix: AppTextWidget(content: '0'),
            suffix: Icon(Icons.phone_android_outlined),
            textInputType: TextInputType.phone,
          ),
          SizedBox(height: 20.h),
          AppTextField(
            controller: passwordEditingController,
            label: 'Password',
            suffix: Icon(Icons.lock),
            isPassword: true,
          ),
          SizedBox(height: 15.h),
          GestureDetector(
            child: Container(
              child: AppTextWidget(content: 'Forgot password?'),
              alignment: AlignmentDirectional.centerEnd,
            ),
            onTap: () => Get.to(ForgetPassword()),
          ),
          SizedBox(height: 42.h),
          AppElevatedButton(
            text: 'Login',
            buttonColor: AppColors.PRIMARY_COLOR,
            fontWeight: FontWeight.bold,
            onPressed: () async {
              await performLogin();
            },
          ),
          SizedBox(
            height: 170.h,
          ),
          Container(
            child: RichText(
              text: TextSpan(
                text: 'I don\'t have an account ?',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'montserrat',
                  fontSize: 15.sp,
                ),
                children: [
                  TextSpan(
                    recognizer: recognizer,
                    text: ' Sign Up',
                    style: TextStyle(
                      color: AppColors.PRIMARY_TEXT_COLOR,
                      fontFamily: 'sf',
                      fontSize: 15.sp,
                    ),
                  )
                ],
              ),
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (phoneEditingController.text.isNotEmpty &&
        passwordEditingController.text.isNotEmpty) {
      return true;
    }
    Helper.showSnackBar(context, text: 'Enter Required Fields', error: true);
    return false;
  }

  Future<void> login() async {
    bool status = await UsersGetxController.to.login(
      context: context,
      mobile: phoneEditingController.text,
      password: passwordEditingController.text,
    );
    if (status) {
      Get.off(MainScreen());
    } else {
      Helper.showSnackBar(context, text: 'Login failed, check your credentials!', error: true);
    }
  }
}
