import 'package:flutter/material.dart';
import 'package:fluttertest/Screens/addtoCart.dart';
import 'package:fluttertest/controller/cart_controller.dart';
import 'package:fluttertest/controller/product_controller.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final myController = Get.put(ProductController());
    final myCartController = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Mall"),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(AddtoCartScreen());
              },
              icon: Icon(Icons.shopping_cart_rounded))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Obx(
          () => myController.isDataProcessing.value
              ? Center(child: CircularProgressIndicator())
              : myController.pList != null && myController.pList.length == 0
                  ? Center(
                      child: Text(
                        "No product yet",
                      ),
                    )
                  : GridView.builder(
                      controller: myController.scrollController,
                      padding: EdgeInsets.all(4),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemCount: myController.pList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        final item = myController.pList[index];
                        return Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Image.network(item.featuredImage)),
                              ),
                              Container(
                                color: Colors.white,
                                child: ListTile(
                                  title: Text(item.title),
                                  trailing: IconButton(
                                      onPressed: () {
                                        myCartController.insert(item);
                                      },
                                      icon: Icon(Icons.shopping_cart_rounded)),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              // color: Colors.grey.withOpacity(.2),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade100,
                                  blurRadius: 1,
                                  spreadRadius: 0.9,
                                )
                              ]),
                        );
                      }),
        ),
      ),
    );
  }
}
