import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Products {
  String? productId;
  String? productName;
  String? productImage;
  String? productPrice;
  int? isSales;
  String? description;
  String? image;
  String? status;
  Products({
    this.productId,
    this.productName,
    this.productImage,
    this.productPrice,
    this.isSales,
    this.description,
    this.image,
    this.status,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      status: json['status'] ?? '',
      productId: json['product_id'] ?? '',
      productName: json['product_name'] ?? '',
      productImage: json['product_image'] ?? '',
      productPrice: json['product_price'] ?? '',
      isSales: json['is_sales'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

