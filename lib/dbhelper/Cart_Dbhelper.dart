import 'package:fluttertest/Models/productcart.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DbProductManager {
  Database? _database;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "ss6.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE products(id INTEGER PRIMARY KEY autoincrement, pname TEXT, pid TEXT, pimage TEXT, pprice TEXT, pQuantity INTEGER, pdiscription TEXT,totalQuantity TEXT)",

        );
      } );
    }
  }

  Future<int> insertProduct(ProductsCart products) async {
    await openDb();
    return await _database!.insert('products', products.toMap());
  }

  Future<List<ProductsCart>> getProductList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.query('products',orderBy: "id ASC");
    return List.generate(maps.length, (i) {
      return ProductsCart(
          id: maps[i]['id'], title: maps[i]['pname'], pid: maps[i]['pid'], featuredImage: maps[i]['pimage'], price: maps[i]['pprice'],
          pQuantity: maps[i]['pQuantity'],description: maps[i]['pdiscription'],totalQuantity: maps[i]['totalQuantity']);
    });
  }

  Future<int> updateProduct(ProductsCart products) async {
    await openDb();
    return await _database!.update('products', products.toMap(),
        where: "id = ?", whereArgs: [products.id]);
  }

  Future<void> deleteProduct(int id) async {
    await openDb();
    await _database!.delete(
        'products',
        where: "id = ?", whereArgs: [id]
    );
  }

  Future<void> deleteallProduct() async {
    await openDb();
    await _database!.delete('products');
  }
}
