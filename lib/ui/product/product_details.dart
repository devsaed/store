import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/cart_getx_controller.dart';
import 'package:said_store/getx/product_getx_controller.dart';
import 'package:said_store/model/cart_item.dart';
import 'package:said_store/model/product_details.dart';
import 'package:said_store/ui/widgets/app_elevated_button.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:said_store/utils/app_colors.dart';
import 'package:said_store/utils/helper.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductDetails productDetails;

  ProductDetailsScreen({required this.productDetails});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int cardIncrement = 1;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await ProductGetxController.to
          .getProductDetails(id: widget.productDetails.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: GetX<ProductGetxController>(
            builder: (ProductGetxController controller) {
          return controller.loading.value
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    // CachedNetworkImage(
                    //   imageUrl: ProductGetxController
                    //       .to.productDetails.value!.images[2].imageUrl,
                    //   placeholder: (context, url) => Center(
                    //     child: CircularProgressIndicator(
                    //       color: AppColors.PRIMARY_COLOR,
                    //     ),
                    //   ),
                    //   errorWidget: (context, url, error) => Icon(Icons.error),
                    //   height: 445.h,
                    //   width: double.infinity,
                    //   fit: BoxFit.cover,
                    // ),
                    SizedBox(
                      height: 445.h,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 445.h,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          // enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: ProductGetxController
                            .to.productDetails.value!.images
                            .map((ProductImages image) {
                          return Builder(
                            builder: (BuildContext context) {
                              return CachedNetworkImage(
                                height: 400,
                                width: double.infinity,
                                imageUrl: image.imageUrl,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.PRIMARY_COLOR,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.cover,
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Container(
                        height: 413.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.h),
                            topRight: Radius.circular(40.h),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppTextWidget(
                                    content: ProductGetxController
                                        .to.productDetails.value!.nameEn,
                                    color: Colors.black,
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await ProductGetxController.to
                                          .addFavoriteProducts(
                                              context: context,
                                              product: ProductGetxController
                                                  .to.productDetails.value!);
                                    },
                                    child: Container(
                                      height: 52,
                                      width: 52,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ProductGetxController
                                                  .to
                                                  .productDetails
                                                  .value!
                                                  .isFavorite
                                              ? Colors.red
                                              : Colors.grey),
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ProductGetxController.to.productDetails.value!
                                          .offerPrice !=
                                      null
                                  ? AppTextWidget(
                                      content:
                                          'Price : ${ProductGetxController.to.productDetails.value!.price} \$  + ${ProductGetxController.to.productDetails.value!.offerPrice}',
                                      color: Colors.black,
                                      fontSize: 21.sp,
                                      fontWeight: FontWeight.w600,
                                      textAlign: TextAlign.start,
                                    )
                                  : AppTextWidget(
                                      content:
                                          'Price : ${ProductGetxController.to.productDetails.value!.price} \$',
                                      color: Colors.black,
                                      fontSize: 21.sp,
                                      fontWeight: FontWeight.w600,
                                      textAlign: TextAlign.start,
                                    ),
                              SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              AppTextWidget(
                                content: ProductGetxController
                                    .to.productDetails.value!.infoEn,
                                color: Colors.grey,
                                fontSize: 16.sp,
                                textAlign: TextAlign.start,
                              ),
                              // RatingBar.builder(
                              //   initialRating: double.parse(
                              //       ProductGetxController
                              //           .to.productDetails.value!.productRate
                              //           .toString()),
                              //   minRating: 1,
                              //   direction: Axis.horizontal,
                              //   allowHalfRating: true,
                              //   itemCount: 5,
                              //   itemPadding:
                              //       EdgeInsets.symmetric(horizontal: 4.0),
                              //   itemSize: 50,
                              //   itemBuilder: (context, _) => Icon(
                              //     Icons.star,
                              //     color: Colors.amber,
                              //   ),
                              //   onRatingUpdate: (rating) {
                              //     ProductGetxController.to.rattingProduct(
                              //         product: widget.product,
                              //         context: context,
                              //         rate: rating);
                              //   },
                              // ),
                              Spacer(),
                              AppElevatedButton(
                                onPressed: () {
                                  showCartDialog();
                                },
                                text: 'Add to cart',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        }));
  }

  showCartDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          StatefulBuilder(builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            // clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColors.PRIMARY_COLOR,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  child: AppTextWidget(
                    content: 'Add To Card',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: CachedNetworkImage(
                          imageUrl: widget.productDetails.imageUrl,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: AppColors.PRIMARY_COLOR,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.antiAlias,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              FloatingActionButton(
                                backgroundColor: AppColors.PRIMARY_TEXT_COLOR,
                                mini: true,
                                onPressed: () {
                                  setState(() {
                                    ++cardIncrement;
                                  });
                                },
                                child: Icon(
                                  Icons.add,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppTextWidget(
                                  content: cardIncrement.toString(),
                                ),
                              ),
                              FloatingActionButton(
                                backgroundColor: AppColors.PRIMARY_TEXT_COLOR,
                                mini: true,
                                onPressed: () {
                                  setState(() {
                                    cardIncrement == 1 ? 1 : --cardIncrement;
                                  });
                                },
                                child: Icon(
                                  Icons.remove,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AppTextWidget(
                              content: 'Total Price: ${widget.productDetails.price * cardIncrement}'),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: AppElevatedButton(
                          onPressed: () async{
                            bool status = await CartGetxController.to.createCartItem(cartItem);
                            if(status){
                              Helper.showSnackBar(context, text: 'add suc');
                              cardIncrement = 1;

                            }else{
                              Helper.showSnackBar(context, text: 'add fal');
                              cardIncrement = 1;
                            }
                            Get.back();
                          },
                          text: 'Add',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: AppElevatedButton(
                          onPressed: (){
                            cardIncrement = 1;
                            Get.back();
                          },
                          text: 'Cancel',
                          buttonColor: Colors.red.shade900,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  CartItem get cartItem {
    CartItem cartItem = CartItem();
    cartItem.imageUrl = widget.productDetails.imageUrl;
    cartItem.productId = widget.productDetails.id;
    cartItem.price = widget.productDetails.price;
    cartItem.nameEn = widget.productDetails.nameEn;
    cartItem.nameAr = widget.productDetails.nameAr;
    cartItem.quantity = cardIncrement;
    return cartItem;
  }
}
