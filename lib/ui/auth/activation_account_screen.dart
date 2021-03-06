import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/user_getx_controller.dart';
import 'package:said_store/ui/auth/login_screen.dart';
import 'package:said_store/ui/widgets/app_elevated_button.dart';
import 'package:said_store/ui/widgets/app_text_field.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/utils/app_colors.dart';
import 'package:said_store/utils/helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ActivationScreen extends StatefulWidget {
  final String mobile;

  ActivationScreen({required this.mobile});

  @override
  _ActivationScreenState createState() => _ActivationScreenState();
}


class _ActivationScreenState extends State<ActivationScreen> {
  late TextEditingController _codeEditingController;

  @override
  void initState() {
    super.initState();
    _codeEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _codeEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'Activation Account',
          color: AppColors.PRIMARY_TEXT_COLOR,
          fontSize: 20.sp,
        ),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        children: [
          SizedBox(height: 70.h),
          AppTextWidget(
            content: 'Please enter your code number to verification the account',
            color: Colors.grey,
            fontSize: 15.sp,
            fontWeight: FontWeight.normal,
          ),
          SizedBox(
            height: 60.h,
          ),
          AppTextField(
            label: 'Code',
            controller: _codeEditingController,
            textInputType: TextInputType.phone,
          ),
          SizedBox(
            height: 43.h,
          ),
          AppElevatedButton(text: 'Continue',
              onPressed: () async => await performActivate()),
        ],
      ),
    );
  }

  Future<void> performActivate() async {
    if (checkData()) {
      await activate();
    }
  }

  bool checkData() {
    if (_codeEditingController.text.isNotEmpty) {
      return true;
    }
    Helper.showSnackBar(context, text: 'Enter Required Fields', error: true);
    return false;
  }

  Future<void> activate() async {
    bool status = await UsersGetxController.to.activatedAccount(context, code: _codeEditingController.text, mobile: widget.mobile);
    if(status){
      navigateToLoginScreen();
    }
  }

  void navigateToLoginScreen() {
    Get.offAll(LoginScreen());
  }
}
