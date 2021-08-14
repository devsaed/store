import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/user_getx_controller.dart';
import 'package:said_store/ui/widgets/app_elevated_button.dart';
import 'package:said_store/ui/widgets/app_text_field.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/utils/app_colors.dart';
import 'package:said_store/utils/helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  late TextEditingController _subjectEditingController;
  late TextEditingController _msgEditingController;

  @override
  void initState() {
    super.initState();
    _subjectEditingController = TextEditingController();
    _msgEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _subjectEditingController.dispose();
    _msgEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'Contact US',
          color: AppColors.PRIMARY_TEXT_COLOR,
          fontSize: 20.sp,
        ),
      ),
      body: ListView(
        padding: EdgeInsetsDirectional.all(50.h),
        children: [
          SizedBox(
            height: 70.h,
          ),
          AppTextWidget(
            content: 'contact us ',
            color: Colors.grey,
            fontFamily: 'sf',
            fontSize: 15.sp,
            fontWeight: FontWeight.normal,
          ),
          SizedBox(height: 60.h),
          AppTextField(
            controller: _subjectEditingController,
            label: 'subject',
            isPassword: true,
          ),
          SizedBox(height: 15),
          AppTextField(
            controller: _msgEditingController,
            label: 'message',
            isPassword: true,
          ),

          SizedBox(
            height: 43.h,
          ),
          AppElevatedButton(
            text: 'Send',
            onPressed: () async => await performContactUs(),
          ),
        ],
      ),
    );
  }

  Future performContactUs() async {
    if (checkData()) {
      await contactUs();
    }
  }

  bool checkData() {
    if (_subjectEditingController.text.isNotEmpty &&
        _msgEditingController.text.isNotEmpty) {
      return true;
    }
    Helper.showSnackBar(context, text: 'Enter Required Fields', error: true);
    return false;
  }

  Future contactUs() async {
    bool status = await UsersGetxController.to.contactUs(context, subject: _subjectEditingController.text, msg: _msgEditingController.text);
    if (status) {
      Get.back();
    }
  }
}
