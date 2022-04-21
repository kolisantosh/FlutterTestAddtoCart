class ProductsCart {
  int id;
  String pid;
  String title;
  String description;
  String price;
  int pQuantity;
  String featuredImage;
  String totalQuantity;


  ProductsCart({required this.title, required this.pid,required this.featuredImage,required this.price,required this.pQuantity,
    required this.description,required this.totalQuantity,required this.id,});
  Map<String, dynamic> toMap() {
    return {'pname': title, 'pid': pid, 'pimage':featuredImage, 'pprice':price, 'pQuantity':pQuantity,'pdiscription':description,
      'totalQuantity': totalQuantity};
  }
}