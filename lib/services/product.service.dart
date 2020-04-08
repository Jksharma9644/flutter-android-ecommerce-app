import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:sawjigrocerryapp/model/product-model.dart';
import 'package:sawjigrocerryapp/model/category-modal.dart';
import 'package:http/http.dart' as http;
import 'package:sawjigrocerryapp/services/base.service.dart';


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

placeorder(request) async {
  var url = getbaseUrl();
  final http.Response response = await http.post(
    url + 'placeorder',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(request),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return json.decode(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
 List <dynamic> convertOrderListToJson(List <Products> list){
    var items =[];
    for (var item in list) {
      items.add({
         'qty': item.qty,
         'id': item.id,
         'productId': item.productId,
         'name': item.name,
         'mrp' :item.mrp
        
      });
    }
     return items;
  
}
getOrders() async {
  var baseurl = getbaseUrl();
  var data = await http.get(baseurl + 'orderlist');
  var jsonData = json.decode(data.body);
  var jsonResponse = jsonData["data"];
   return jsonResponse;
}

getOrderById(clientid) async {
   var baseurl = getbaseUrl();
  var data = await http.get(baseurl + 'order/'+clientid);
  var jsonData = json.decode(data.body);
  var jsonResponse = jsonData["data"]; 
   return jsonResponse;
}
editOrderById(request ,orderId) async {
    var url = getbaseUrl();
  final http.Response response = await http.put(
    url + 'order/update/'+orderId,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(request),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return json.decode(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
