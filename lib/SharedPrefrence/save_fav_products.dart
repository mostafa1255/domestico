import 'dart:convert';
import 'package:domestico/DataLayer/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String favproductsKey = 'products';
const String cartproductsKey = 'cart_products';

void saveFavoriteProductInSharedPreference({required ProductModel item}) {
  SaveFavoriteProducts.getItems().then((items) {
    Set<ProductModel> itemSet = items.toSet();
    itemSet.add(item);
    List<ProductModel> updatedItems = itemSet.toList();
    SaveFavoriteProducts.saveItems(updatedItems);
  });
}

void saveCartProductInSharedPreference({required ProductModel item}) {
  SaveCartProducts.getItems().then((items) {
    Set<ProductModel> itemSet = items.toSet();
    itemSet.add(item);
    List<ProductModel> updatedItems = itemSet.toList();
    SaveCartProducts.saveItems(updatedItems);
  });
}

class SaveCartProducts {
  static Future<void> saveItems(List<ProductModel> items) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonStringList =
        items.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(cartproductsKey, jsonStringList);
  }

  static Future<List<ProductModel>> getItems() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonStringList = prefs.getStringList(cartproductsKey) ?? [];
    print('Stored JSON strings: $jsonStringList');
    return jsonStringList
        .map((jsonString) => ProductModel.fromJson(jsonDecode(jsonString)))
        .toList();
  }
}

class SaveFavoriteProducts {
  static Future<void> saveItems(List<ProductModel> items) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonStringList =
        items.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(favproductsKey, jsonStringList);
  }

  static Future<List<ProductModel>> getItems() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonStringList = prefs.getStringList(favproductsKey) ?? [];
    print('Stored JSON strings: $jsonStringList');
    return jsonStringList
        .map((jsonString) => ProductModel.fromJson(jsonDecode(jsonString)))
        .toList();
  }
}
