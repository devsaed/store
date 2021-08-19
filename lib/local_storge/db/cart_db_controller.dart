
import 'package:said_store/model/cart_item.dart';
import 'package:sqflite/sqflite.dart';

import 'db_operations.dart';
import 'db_provider.dart';

class CartDbController extends DbOperations<CartItem> {
  Database _database;
  CartDbController() : _database = DBProvider().database;

  @override
  Future<int> create(CartItem cartItem) async {
    return await _database.insert('cart', cartItem.toMap());
  }

  @override
  Future<bool> delete(int id) async{
    int countOfDeletedRows = await _database.delete('cart', where: 'id = ?', whereArgs: [id]);
    return countOfDeletedRows != 0;
  }

  @override
  Future<List<CartItem>> read() async{
    var rowsMaps = await _database.query('cart');
    return rowsMaps.map((rowMap) => CartItem.fromMap(rowMap)).toList();
  }

  @override
  Future<CartItem?> show(int id) {
    throw UnimplementedError();
  }

  @override
  Future<bool> update(CartItem data) {
    throw UnimplementedError();
  }

  Future<bool> deleteAllItem()async {
    int countOfDeletedRows = await _database.delete('cart');
    return countOfDeletedRows != 0;
  }

}
