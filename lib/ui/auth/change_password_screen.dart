import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/user_getx_controller.dart';
import 'package:said_store/ui/widgets/app_elevated_button.dart';
import 'package:said_store/ui/widgets/app_text_field.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/utils/app_colors.dart';
import 'package:said_store/utils/helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _oldPasswordEditingController;
  late TextEditingController _newPasswordEditingController;
  late TextEditingController _newPasswordConfirmationEditingController;

  @override
  void initState() {
    super.initState();
    _oldPasswordEditingController = TextEditingController();
    _newPasswordEditingController = TextEditingController();
    _newPasswordConfirmationEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordEditingController.dispose();
    _newPasswordConfirmationEditingController.dispose();
    _newPasswordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'Change Password',
          color: AppColors.PRIMARY_TEXT_COLOR,
          fontSize: 20.sp,
        ),
      ),
      body: ListView(
        padding: EdgeInsetsDirectional.all(50.h),
        children: [
          SizedBox(height: 70.h),
          AppTextWidget(
            content: 'Please enter your phone Number and we will  send you a code to your phone  to rest the password',
            color: Colors.grey,
            fontFamily: 'sf',
            fontSize: 15.sp,
            fontWeight: FontWeight.normal,
          ),
          SizedBox(height: 60.h),
          AppTextField(
            controller: _oldPasswordEditingController,
            label: 'Old Password',
            isPassword: true,
          ),
          SizedBox(height: 15.h),
          AppTextField(
            controller: _newPasswordEditingController,
            label: 'New Password',
            isPassword: true,
          ),
          SizedBox(height: 15.h),
          AppTextField(
            controller: _newPasswordConfirmationEditingController,
            label: 'New password Confirmation',
            isPassword: true,
          ),
          SizedBox(
            height: 43.h,
          ),
          AppElevatedButton(
            text: 'Continue',
            onPressed: () async => await performChangePassword(),
          ),
        ],
      ),
    );
  }

  Future performChangePassword() async {
    if (checkData()) {
      await changePassword();
    }
  }

  bool checkData() {
    if (isPasswordSet) {
      if (isPasswordConfirmed) {
        return true;
      }
      Helper.showSnackBar(context,
          text: 'Password is not confirmed correctly!', error: true);
    } else {
      Helper.showSnackBar(context, text: 'Enter required data!', error: true);
    }
    return false;
  }

  bool get isPasswordSet {
    return _newPasswordEditingController.text.isNotEmpty &&
        _newPasswordConfirmationEditingController.text.isNotEmpty &&
        _oldPasswordEditingController.text.isNotEmpty;
  }

  bool get isPasswordConfirmed {
    return _newPasswordConfirmationEditingController.text ==
        _newPasswordEditingController.text;
  }

  Future changePassword() async {
    bool status = await UsersGetxController.to.changePassword(context,
        currentPassword: _oldPasswordEditingController.text,
        newPassword: _newPasswordConfirmationEditingController.text);
    if (status) {
      navigateToLoginScreen();
    }
  }

  void navigateToLoginScreen() {
    Get.back();
  }
}
