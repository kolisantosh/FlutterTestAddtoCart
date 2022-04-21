import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertest/Models/productModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TaskProvider extends GetConnect {
  int Per_Page=5;

  Future<List<ProductModel>?> fetchProductList(var page) async {
    var headers = {
      'token': 'eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz'
    };
    try {
      var uri=Uri.parse("http://205.134.254.135/~mobile/MtProject/public/api/product_list.php?page=$page&perPage=${Per_Page}");
      var request = http.Request('GET', uri);
      request.headers.addAll(headers);
      final response = await request.send();
      final respStr = await response.stream.bytesToString();
      final jsonBody = await jsonDecode(respStr);
      if (response.statusCode == 200) {
          List<dynamic> jsonbody1 = jsonBody['data'];
          List<ProductModel> list = ProductModel.getListFromJson(jsonbody1);
          return list;
      } else {
        EasyLoading.showError(jsonBody['message']);
      }
    } catch (e) {
      if (e is SocketException) showLongToast("Could not connect to internet");
    }
  }



}

showLongToast(String s) {
  Fluttertoast.showToast(
    msg: s,
    toastLength: Toast.LENGTH_LONG,
  );
}

showSnackbar(title,message,color){
  Get.snackbar( title,message,colorText: Colors.white,backgroundColor: color);
}