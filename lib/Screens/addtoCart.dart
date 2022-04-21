import 'package:flutter/material.dart';
import 'package:fluttertest/controller/cart_controller.dart';
import 'package:get/get.dart';

class AddtoCartScreen extends StatefulWidget {
  const AddtoCartScreen({Key? key}) : super(key: key);

  @override
  _CState createState() => _CState();
}

class _CState extends State<AddtoCartScreen> {

  @override
  Widget build(BuildContext context) {
    final myController = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("My Cart"),
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
                        "empty cart",
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      controller: myController.scrollController,
                      physics: ClampingScrollPhysics(),
                      itemCount: myController.pList != null
                          ? myController.pList.length
                          : 0,
                      itemBuilder: (BuildContext context, int index) {
                        final item = myController.pList[index];
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 0,
                                      child: Container(
                                          height: 120,
                                          width: 120,
                                          alignment: Alignment.center,
                                          child: Image.network(
                                              item.featuredImage)),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.title,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Price"),
                                                Text(
                                                    "\$${item.price.toString()}"),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Quantity"),
                                                Text(item.totalQuantity.toString()),
                                              ],
                                            ),
                                          ],
                                        ),
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
                              ),
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () {
                                      myController.deleteCart(item.id);
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    )))
                          ],
                        );
                      }),
        ),
      ),
      bottomSheet: Obx(()=>Container(
          color: Colors.blueGrey,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 1,
                  child: Text(
                    "Total Item: " + myController.pList.length.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    "Grand Total: " + myController.totalamount.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
