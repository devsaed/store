import 'package:flutter/material.dart';
import 'package:said_store/getx/address_getx_controller.dart';
import 'package:said_store/model/address.dart';
import 'package:said_store/model/address_details.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:said_store/utils/app_colors.dart';

class AddressWidget extends StatelessWidget {
  final AddressDetails address;
  AddressWidget({required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsetsDirectional.only(
          top: 10,
     ),
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
          Radius.circular(7),
        ),
      ),
      height: 70,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: 15,
              end: 15,
              top: 10,
              bottom: 10,
            ),
            child: CircleAvatar(
              radius: 30,
              child: AppTextWidget(
                content: address.name[0].toUpperCase(),
                color: Colors.white,
                fontFamily: 'quicksand',
                fontSize: 22,
                fontWeight: FontWeight.w500,
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
                fontSize: 13,
                fontFamily: 'quicksand',
              ),
              AppTextWidget(
                content: address.contactNumber,
                fontWeight: FontWeight.w500,
                fontSize: 12,
                fontFamily: 'quicksand',
                color: AppColors.PRIMARY_TEXT_COLOR,
              ),
            ],
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async{
              bool status = await deleteAddressDialog(context: context);
              if(status){
                await AddressGetxController.to.deleteAddress(context: context, addressId: address.id);
              }
            },
          ),
          Container(
            alignment: AlignmentDirectional.center,
            color: AppColors.PRIMARY_TEXT_COLOR,
            child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: ()async{
                  // await AddressGetxController.to.deleteAddress(context: context, addressId: address.id);
                },
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> deleteAddressDialog({required BuildContext context}) async {
    bool status = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Address'),
            content: Text('Are you sure you want to delete this Address?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text('No')),

              TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text('Yes'))
            ],
          );
        });
    return status;
  }
}
