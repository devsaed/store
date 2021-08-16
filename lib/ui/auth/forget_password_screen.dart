import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/user_getx_controller.dart';
import 'package:said_store/ui/auth/reset_password_screen.dart';
import 'package:said_store/ui/widgets/app_elevated_button.dart';
import 'package:said_store/ui/widgets/app_text_field.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/utils/app_colors.dart';
import 'package:said_store/utils/helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late TextEditingController _phoneEditingController;
  @override
  void initState() {
    super.initState();
    _phoneEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'Forget Password',
          color: AppColors.PRIMARY_TEXT_COLOR,
          fontSize: 20.sp,
        ),
      ),
      body: ListView(
        padding: EdgeInsetsDirectional.all(50.h),
        children: [
          SizedBox(height: 70.h,),
          AppTextWidget(
            content: 'Please enter your phone Number and we will  send you a code to your phone  to rest the password',
            color: Colors.grey,
            fontFamily: 'sf',
            fontSize: 15.sp,
            fontWeight: FontWeight.normal,
          ),
          SizedBox(height: 60.h),
          AppTextField(
            label: 'mobile number',
            controller: _phoneEditingController,
            textInputType: TextInputType.phone,
          ),
          SizedBox(
            height: 43.h,
          ),
          AppElevatedButton(text: 'Continue', onPressed: ()async {
            await performForgetPassword();
          }),
        ],
      ),
    );
  }


  Future performForgetPassword() async {
    if (checkData()) {
      await forgetPassword();
    }
  }

  bool checkData() {
    if (_phoneEditingController.text.isNotEmpty) {
      return true;
    }
    Helper.showSnackBar(context, text: 'Enter required data!', error: true);
    return false;
  }

  Future forgetPassword() async {
    bool status = await UsersGetxController.to.forgetPassword(context, mobile: _phoneEditingController.text);
    if (status) {
      navigateToResetPassword();
    }
  }
  void navigateToResetPassword() {
    Get.to(ResetPasswordScreen(phone: _phoneEditingController.text,));
  }
}
