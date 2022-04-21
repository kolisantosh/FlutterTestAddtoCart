import 'dart:convert';

ProductModel welcomeFromJson(String str) => ProductModel.fromJson(json.decode(str));

String welcomeToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.price,
    required this.featuredImage,
    required this.status,
    required this.createdAt,
  });

  int id;
  String slug;
  String title;
  String description;
  int price;
  String featuredImage;
  String status;
  DateTime createdAt;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    slug: json["slug"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    featuredImage: json["featured_image"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "title": title,
    "description": description,
    "price": price,
    "featured_image": featuredImage,
    "status": status,
    "created_at": createdAt.toIso8601String(),
  };

  static List<ProductModel> getListFromJson(List<dynamic> list) {
    List<ProductModel> unitList = [];
    list.forEach((unit) => unitList.add(ProductModel.fromJson(unit)));
    return unitList;
  }

}
