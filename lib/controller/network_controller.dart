import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  StreamSubscription? subscription;
  var offline = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    initConnectivity();
    super.onInit();
  }

  initConnectivity()
   {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        offline.value=true;
      } else if (result == ConnectivityResult.mobile) {
        offline.value=false;
      } else if (result == ConnectivityResult.wifi) {
        offline.value=false;
      }
      else{
        Get.snackbar("Network Error","Failed to get network connection");
      }
    });

  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
