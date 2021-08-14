//
// import 'package:said_store/model/product.dart';
// import 'package:sqflite/sqflite.dart';
//
// import 'db_operations.dart';
// import 'db_provider.dart';
//
// class CartDbController extends DbOperations<Product> {
//   Database _database;
//
//   CartDbController() : _database = DBProvider().database;
//
//
//   @override
//   Future<int> create(Product data) {
//     return _database.insert('cart', data.toMap());
//   }
//
//   @override
//   Future<List<UserAction>> read() async {
//     List<Map<String, dynamic>> data = await _database.query('actions',
//         where: 'user_id = ?', whereArgs: [UsersGetxController.to.user.id]);
//     if (data.isNotEmpty) {
//       return data.map((rowMap) => UserAction.fromMap(rowMap)).toList();
//     }
//     return [];
//   }
//
//   @override
//   Future<bool> update(UserAction data) {
//     // TODO: implement update
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<bool> delete(int id) {
//     // TODO: implement delete
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<UserAction?> show(int id) {
//     // TODO: implement show
//     throw UnimplementedError();
//   }
//
//   Future<bool> deleteUserActions(int userId) async{
//     int deleteRowsCount = await _database.delete('actions',where: 'user_id = ?',whereArgs: [userId]);
//     return deleteRowsCount > 0;
//   }
// }
