import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:sawjigrocerryapp/model/product-model.dart';
import 'package:sawjigrocerryapp/model/category-modal.dart';
import 'package:http/http.dart' as http;

getbaseUrl() {
  var uaturl = 'https://arcane-mesa-86746.herokuapp.com/';
  final url = 'http://192.168.31.162:3000/';
  return url;
}

Future<List<Products>> getProducts() async {
  var baseurl = getbaseUrl();
  var data = await http.get(baseurl + 'productlist/admin');
  var jsonData = json.decode(data.body);
  var jsonResponse = jsonData["data"];
  List<Products> products = [];
  for (var item in jsonResponse) {
    Products product = Products.fromJson(item);
    products.add(product);
  }
  print(products.length);

  return products;
}

getProductsByCategory(category) async {
  var baseurl = getbaseUrl();
  var data = await http.get(baseurl + 'product/' + category);
  var jsonData = json.decode(data.body);
  var jsonResponse = jsonData["data"];
   List <Products> products = [];
  for (var item in jsonResponse) {
     Products product = Products.fromJson(item);
    products.add(product);
  }
  print(products.length);
  return products;
}

Future<List<ProductType>> getallProductType() async {
  var baseurl = getbaseUrl();
  var data = await http.get(baseurl + 'categoryList');
  var jsonData = json.decode(data.body);
  var jsonResponse = jsonData["data"];
  List<ProductType> productTypes = [];
  for (var item in jsonResponse) {
    ProductType category = ProductType.fromJson(item);
    productTypes.add(category);
  }
  print(productTypes.length);

  return productTypes;
}



getproductCategoriesById(id) async {
  var baseurl = getbaseUrl();
  var data = await http.get(baseurl + 'category/' + id);
  var jsonData = json.decode(data.body);
  var jsonResponse = jsonData["data"];
  return jsonResponse;
}
