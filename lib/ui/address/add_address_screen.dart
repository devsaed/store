import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/address_getx_controller.dart';
import 'package:said_store/local_storge/shared_preferences/preferences.dart';
import 'package:said_store/model/address_details.dart';
import 'package:said_store/ui/widgets/app_elevated_button.dart';
import 'package:said_store/ui/widgets/app_text_field.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/utils/app_colors.dart';
import 'package:said_store/utils/helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  late TextEditingController nameEditingController;
  late TextEditingController infoEditingController;
  late TextEditingController contactNumberEditingController;


  @override
  void initState() {
    super.initState();
    nameEditingController = TextEditingController();
    infoEditingController = TextEditingController();
    contactNumberEditingController = TextEditingController();
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    infoEditingController.dispose();
    contactNumberEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'Add Address',
          color: AppColors.PRIMARY_TEXT_COLOR,
          fontSize: 20.sp,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(32.h),
        children: [
          SizedBox(height: 30.h),
          AppTextField(
            controller: contactNumberEditingController,
            label: 'Phone Number',
            prefix: AppTextWidget(content: '0'),
            textInputType: TextInputType.phone,
          ),
          SizedBox(height: 20.h),
          AppTextField(
            controller: nameEditingController,
            label: 'Name',
          ),
          SizedBox(height: 15.h),
          AppTextField(
            controller: infoEditingController,
            label: 'info : Country, City, Street',
          ),
          SizedBox(height: 42.h),
          AppElevatedButton(
            text: 'Add',
            buttonColor: AppColors.PRIMARY_COLOR,
            fontWeight: FontWeight.bold,
            onPressed: () async {
              await performAdd();
            },
          ),
          SizedBox(
            height: 170.h,
          ),
        ],
      ),
    );
  }

  Future<void> performAdd() async {
    if (checkData()) {
      await save();
    }
  }

  bool checkData() {
    if (
        nameEditingController.text.isNotEmpty &&
        infoEditingController.text.isNotEmpty &&
        contactNumberEditingController.text.isNotEmpty) {
      return true;
    }
    Helper.showSnackBar(context, text: 'Enter Required Fields', error: true);
    return false;
  }

  Future<void> save() async {
    AddressDetails address = AddressDetails();
    address.name = nameEditingController.text;
    address.contactNumber = contactNumberEditingController.text;
    address.info = infoEditingController.text;
    address.cityId = SharedPreferencesController().user!.cityId;

    bool status = await AddressGetxController.to.createAddress(
      context: context,
      address: address
    );
    if (status) {
      Navigator.pop(context);
    } else {
      Helper.showSnackBar(context, text: 'error', error: true);
    }
  }
}
