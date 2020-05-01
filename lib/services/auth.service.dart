import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sawjigrocerryapp/services/base.service.dart';
import '../model/profile-model.dart';

signUp(request) async {
  var url = getbaseUrl();
  final http.Response response = await http.post(
    url + 'auth/register',
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

signIn(request) async {
 var url = getbaseUrl();
  final http.Response response = await http.post(
    url + 'auth/sign_in',
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
updateProfile(request ,id) async{
  var url = getbaseUrl();
  final http.Response response = await http.put(
    url + '/auth/editProfile/'+id,
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

sendOTP(request) async {
  var url = getbaseUrl();
  final http.Response response = await http.post(
    url + 'auth/sendOTP',
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
    throw Exception('Failed');
  }
}
verifyOTP(request) async {
  var url = getbaseUrl();
  final http.Response response = await http.post(
    url + 'auth/verifyOTP',
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
    throw Exception('Failed');
  }
}
Future<String> _loadProduct() async{
  return await rootBundle.loadString('assets/address.json');
}

getUserProfile(id) async{
   var url = getbaseUrl();
    final http.Response response = await http.get(url+'auth/getUserProfile/'+id);
    if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed');
  }
 
}