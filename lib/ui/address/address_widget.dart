import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/address_getx_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:said_store/model/address_details.dart';
import 'package:said_store/ui/address/address_edite_screen.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/utils/app_colors.dart';

class AddressWidget extends StatelessWidget {
  final AddressDetails address;
  final void Function() onTap;

  AddressWidget({required this.address,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsetsDirectional.only(top: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withAlpha(25),
              offset: Offset(0, 0),
              blurRadius: 6,
              spreadRadius: 3,
            )
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(7.h),
          ),
        ),
        height: 70.h,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 8.w,
                end: 8.w,
                top: 8.h,
                bottom: 8.h,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade100,
                radius: 30.h,
                child: Icon(
                  Icons.location_on,
                  color: Colors.red.shade900,
                  size: 30.h,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextWidget(
                  content: address.info,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                ),
                SizedBox(height: 5.h),
                AppTextWidget(
                  content: address.contactNumber,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: AppColors.PRIMARY_TEXT_COLOR,
                ),
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async => await performDialog(context),
            ),
            Container(
              alignment: AlignmentDirectional.center,
              color: AppColors.PRIMARY_COLOR,
              child: IconButton(
                onPressed: () => Get.to(EditAddressScreen(address: address)),
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> deleteAddressDialog({required BuildContext context}) async {
    bool status = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: AppTextWidget(
              content: 'Delete Address',
              textAlign: TextAlign.start,
            ),
            content: AppTextWidget(
              content: 'Are you sure you want to delete this Address?',
              textAlign: TextAlign.start,
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: AppTextWidget(content: 'No'),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: AppTextWidget(content: 'Yes'),
              ),
            ],
          );
        });
    return status;
  }

  Future<void> performDialog(BuildContext context) async {
    bool status = await deleteAddressDialog(context: context);
    if (status) {
      await AddressGetxController.to
          .deleteAddress(context: context, addressId: address.id);
    }
  }

}
