import 'package:said_store/model/product_details.dart';

class Home {
  late List<MySlider> slider;
  late List<Categories> categories;
  late List<ProductDetails> latestProducts;
  late List<ProductDetails> famousProducts;
  Home();

  Home.fromJson(Map<String, dynamic> json) {
    if (json['slider'] != null) {
      slider = <MySlider>[];
      json['slider'].forEach((v) {
        slider.add(MySlider.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(Categories.fromJson(v));
      });
    }
    if (json['latest_products'] != null) {
      latestProducts = <ProductDetails>[];
      json['latest_products'].forEach((v) {
        latestProducts.add(ProductDetails.fromJson(v));
      });
    }
    if (json['famous_products'] != null) {
      famousProducts = <ProductDetails>[];
      json['famous_products'].forEach((v) {
        famousProducts.add(ProductDetails.fromJson(v));
      });
    }
  }
}

class MySlider {
  late int id;
  late String url;
  late String imageUrl;

  MySlider();

  MySlider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    imageUrl = json['image_url'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class Categories {
  late int id;
  late String nameEn;
  late String nameAr;
  late String image;
  late String imageUrl;

  Categories();

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
    return data;
  }

}