import 'package:get/get.dart';
import 'package:said_store/local_storge/db/cart_db_controller.dart';
import 'package:said_store/model/cart_item.dart';

class CartGetxController extends GetxController {
  RxList<CartItem> cartItem = <CartItem>[].obs;
  CartDbController dbController = CartDbController();
  RxBool loading = false.obs;


  static CartGetxController get to => Get.find();

  @override
  void onInit() {
    readCartItem();
    super.onInit();
  }

  @override
  void onClose() {
    cartItem.clear();
    super.onClose();
  }

  Future<void> readCartItem() async {
    loading = true.obs;
    cartItem.value = await dbController.read();
    update();
    loading = false.obs;
  }

  Future<bool> createCartItem(CartItem newCartItem) async {
    loading = true.obs;
    int id = await dbController.create(newCartItem);
    if (id != 0) {
      newCartItem.id = id;
      cartItem.add(newCartItem);
      update();
      loading = false.obs;
      return true;
    }
    loading = false.obs;
    return false;
  }

  Future<bool> deleteItem(int id) async {
    loading = true.obs;
    bool deleted = await dbController.delete(id);
    if (deleted) {
      cartItem.removeWhere((element) => element.id == id);
      update();
      loading = false.obs;
      return true;
    }
    loading = false.obs;
    return deleted;
  }

  Future<bool> deleteAllItem() async {

    bool deleted = await dbController.deleteAllItem();
    if (deleted) {
      cartItem.clear();
      update();
      return true;
    }

    return deleted;
  }

}
