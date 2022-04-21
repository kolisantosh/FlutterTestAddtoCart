import 'package:flutter/material.dart';
import 'package:fluttertest/Models/productModel.dart';
import 'package:fluttertest/Models/productcart.dart';
import 'package:fluttertest/controller/task_provider.dart';
import 'package:fluttertest/dbhelper/Cart_Dbhelper.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
 var pList=List<ProductsCart>.empty(growable: true).obs;
 var isDataProcessing=false.obs;

 ScrollController scrollController=ScrollController();
 final DbProductManager dbmanager = new DbProductManager();
var totalamount=0.0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTask();
  }


  void getTask(){
    try{
        isDataProcessing.value = true;
        dbmanager.getProductList().then((resp) {
          isDataProcessing.value = false;
          pList.clear();
          totalamount=0;
          pList.addAll(resp);
          for (var i = 0; i < pList.length; i++) {
            totalamount = totalamount + double.parse(pList[i].price);
          }
        }, onError: (err) {
          isDataProcessing.value = false;
          showSnackbar("Error", err.toString(), Colors.red);
          print(err.toString());
        });
    }catch(e){
      isDataProcessing.value=false;
      showSnackbar( "Exception",e.toString(),Colors.red);
    }
  }

  void insert(ProductModel item){
    ProductsCart st = ProductsCart(
      id: item.id,
      pid: item.id.toString(),
      title: item.title,
      featuredImage: item.featuredImage,
      price: item.price.toString(),
      pQuantity: 1,
      description: item.description,
      totalQuantity: "1",
    );
    dbmanager.insertProduct(st).then((id) => {
      showLongToast(" Products  is added to cart "),
      print(' Added to Db ${id} '+pList.length.toString()),
      getTask(),
    });
  }

  void deleteCart(id){
    dbmanager.deleteProduct(id);
    getTask();

  }

 showSnackbar(title,message,color){
    Get.snackbar( title,message,colorText: Colors.white,backgroundColor: color);
  }



 @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }
}
