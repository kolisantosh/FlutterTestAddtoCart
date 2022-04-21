import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/Models/productModel.dart';
import 'package:fluttertest/controller/task_provider.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var pList = List<ProductModel>.empty(growable: true).obs;
  var page = 1;
  var isDataProcessing = false.obs;

  ScrollController scrollController = ScrollController();
  var isMoreDataAvailable = false.obs;
  int currentPage = 1;

  StreamSubscription? subscription;
  var isoffline = false.obs;

  checkNetwork() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isoffline.value = true;
      } else if (result == ConnectivityResult.mobile) {
        isoffline.value = false;
      } else if (result == ConnectivityResult.wifi) {
        isoffline.value = false;
      } else {
        Get.snackbar("Network Error", "Failed to get network connection");
        isoffline.value = true;
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkNetwork();
    getTask();
    paginateTask();
  }

  void getTask() {
    try {
      if (isoffline.value == false) {
        isDataProcessing.value = true;
        TaskProvider().fetchProductList(page).then((resp) {
          isDataProcessing.value = false;
          pList.clear();
          pList.addAll(resp!);
        }, onError: (err) {
          isDataProcessing.value = false;
          showSnackbar("Error", err.toString(), Colors.red);
        });
      }
    } catch (e) {
      isDataProcessing.value = false;
      showSnackbar("Exception", e.toString(), Colors.red);
    }
  }

  void paginateTask() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page++;
        getMoreTask(page);
      }
    });
  }

  void getMoreTask(var page) {
    try {
      if (isoffline.value == false) {
        isMoreDataAvailable.value = true;
        TaskProvider()
            .fetchProductList(
          page,
        )
            .then((resp) {
          if (resp!.isNotEmpty) {
            isMoreDataAvailable.value = false;
          } else {
            isMoreDataAvailable.value = false;
          }
          pList.addAll(resp);
        }, onError: (err) {
          isDataProcessing.value = false;
          showSnackbar("Error", err.toString(), Colors.red);
        });
      }
    } catch (e) {
      isDataProcessing.value = false;
      showSnackbar("Exception", e.toString(), Colors.red);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }
}
