class Product {
  late int id;
  late String nameEn;
  late String nameAr;
  late String infoEn;
  late String infoAr;
  late int price;
  late int quantity;
  late int overalRate;
  late int subCategoryId;
  late num productRate;
  late int? offerPrice;
  late bool isFavorite;
  late String imageUrl;

  Product();

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    infoEn = json['info_en'];
    infoAr = json['info_ar'];
    price = json['price'];
    quantity = json['quantity'];
    overalRate = json['overal_rate'];
    subCategoryId = json['sub_category_id'];
    productRate = json['product_rate'];
    offerPrice = json['offer_price'];
    isFavorite = json['is_favorite'];
    imageUrl = json['image_url'];
  }

  Product.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    nameEn = data['name_en'];
    nameAr = data['name_ar'];
    infoEn = data['info_en'];
    infoAr = data['info_ar'];
    price = data['price'];
    quantity = data['quantity'];
    overalRate = data['overal_rate'];
    subCategoryId = data['sub_category_id'];
    productRate = data['product_rate'];
    offerPrice = data['offer_price'];
    isFavorite = data['is_favorite'];
    imageUrl = data['image_url'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['info_en'] = this.infoEn;
    data['info_ar'] = this.infoAr;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['overal_rate'] = this.overalRate;
    data['sub_category_id'] = this.subCategoryId;
    data['product_rate'] = this.productRate;
    data['offer_price'] = this.offerPrice;
    data['is_favorite'] = this.isFavorite;
    data['image_url'] = this.imageUrl;
    return data;
  }
}