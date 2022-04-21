import 'package:fluttertest/controller/cart_controller.dart';
import 'package:fluttertest/controller/product_controller.dart';
import 'package:get/get.dart';
import 'network_controller.dart';

class NetworkBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<NetworkController>(() => NetworkController());
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<CartController>(() => CartController());

  }

}