import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/user_getx_controller.dart';
import 'package:said_store/ui/auth/login_screen.dart';
import 'package:said_store/ui/widgets/app_elevated_button.dart';
import 'package:said_store/ui/widgets/app_text_field.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/ui/widgets/code_text_field.dart';
import 'package:said_store/utils/app_colors.dart';
import 'package:said_store/utils/helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String phone;

  ResetPasswordScreen({required this.phone});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String _code = '';
  late TextEditingController _newPasswordEditingController;
  late TextEditingController _newPasswordConfirmationEditingController;

  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;

  late FocusNode firstFocusNode;
  late FocusNode secondFocusNode;
  late FocusNode thirdFocusNode;
  late FocusNode fourthFocusNode;

  @override
  void initState() {
    super.initState();
    _newPasswordEditingController = TextEditingController();
    _newPasswordConfirmationEditingController = TextEditingController();

    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();

    firstFocusNode = FocusNode();
    secondFocusNode = FocusNode();
    thirdFocusNode = FocusNode();
    fourthFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _newPasswordEditingController.dispose();
    _newPasswordConfirmationEditingController.dispose();

    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _fourthCodeTextController.dispose();

    firstFocusNode.dispose();
    secondFocusNode.dispose();
    thirdFocusNode.dispose();
    fourthFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,

      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'Reset Password',
          color: AppColors.PRIMARY_TEXT_COLOR,
          fontSize: 20.sp,
        ),
      ),
      body: ListView(
        padding: EdgeInsetsDirectional.all(50.h),
        shrinkWrap: true,
        children: [
          SizedBox(height: 70.h),
          AppTextWidget(
            content: 'Enter 4 digit code verification, the code sent to your phone',
            color: Colors.grey,
            fontSize: 15.sp,
            fontWeight: FontWeight.normal,
          ),
          SizedBox(
            height: 100.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CodeTextField(
                  textController: _firstCodeTextController,
                  focusNode: firstFocusNode,
                  onChanged: (String value) {
                    if (value.isNotEmpty) secondFocusNode.requestFocus();
                  },
                ),
                SizedBox(width: 15.w),
                CodeTextField(
                  textController: _secondCodeTextController,
                  focusNode: secondFocusNode,
                  onChanged: (String value) {
                    if (value.isEmpty)
                      firstFocusNode.requestFocus();
                    else
                      thirdFocusNode.requestFocus();
                  },
                ),
                SizedBox(width: 15.w),
                CodeTextField(
                  textController: _thirdCodeTextController,
                  focusNode: thirdFocusNode,
                  onChanged: (String value) {
                    if (value.isEmpty)
                      secondFocusNode.requestFocus();
                    else
                      fourthFocusNode.requestFocus();
                  },
                ),
                SizedBox(width: 15.w),
                CodeTextField(
                  textController: _fourthCodeTextController,
                  focusNode: fourthFocusNode,
                  onChanged: (String value) {
                    if (value.isEmpty) thirdFocusNode.requestFocus();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          AppTextField(
            controller: _newPasswordEditingController,
            label: 'Password',
            isPassword: true,
          ),
          SizedBox(height: 15.h),
          AppTextField(
            controller: _newPasswordConfirmationEditingController,
            label: 'Confirm Password',
            isPassword: true,
          ),
          SizedBox(height: 43.h),
          AppElevatedButton(
            text: 'Continue',
            onPressed: () async => await performResetPassword(),
          ),
        ],
      ),
    );
  }

  Future performResetPassword() async {
    if (checkData()) {
      await resetPassword();
    }
  }

  bool checkData() {
    if (isValidCode() && isPasswordSet) {
      if (isPasswordConfirmed) {
        return true;
      }
      Helper.showSnackBar(context, text: 'Password is not confirmed correctly!', error: true);
    } else {
      Helper.showSnackBar(context, text: 'Enter required data!', error: true);
    }
    return false;
  }

  bool get isPasswordSet {
    return _newPasswordEditingController.text.isNotEmpty &&
        _newPasswordConfirmationEditingController.text.isNotEmpty;
  }

  bool isValidCode() => code.isNotEmpty && _code.length == 4;

  bool get isPasswordConfirmed {
    return _newPasswordConfirmationEditingController.text ==
        _newPasswordEditingController.text;
  }

  String get code {
    return _code = _firstCodeTextController.text +
        _secondCodeTextController.text +
        _thirdCodeTextController.text +
        _fourthCodeTextController.text;
  }

  Future resetPassword() async {
    bool status = await UsersGetxController.to.resetPassword(
      context: context,
      mobile: widget.phone,
      password: _newPasswordEditingController.text,
      code: code,
    );
    if (status) {
      navigateToLoginScreen();
    }
  }

  void navigateToLoginScreen() {
    Get.offAll(LoginScreen());
  }
}
