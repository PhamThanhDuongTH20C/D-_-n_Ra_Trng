import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/product_model.dart';

String? validateMT(String txt) {
  try {
    if (txt.isEmpty) {
      return "Không được BỎ TRỐNG";
    } else {
      return null;
    }
  } catch (e) {
    return 'Đừng bỏ Trống Ô';
  }
}

dynamic validateTP(String txt) {
  try {
    if (txt.length < 5) {
      return 'Tên phải có 5 ký tự!!!';
    } else {
      return null;
    }
  } catch (e) {
    return 'Tên phải có 5 ký tự!!!';
  }
}

String? validateGia(String txt) {
  try {
    if (int.tryParse(txt)! <= 0) {
      return 'Vui lòng nhập số Dương';
    } else {
      return null;
    }
  } catch (e) {
    return 'Bạn hãy nhập số';
  }
}

dynamic validateEmail(String value) {
  try {
    if (value.isEmpty) {
      return "Tài Khoản kkhông được BỎ TRỐNG";
    } else if (value.isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return "Email:abc@gmail.com";
    } else {
      return null;
    }
  } catch (e) {
    return 'Bạn đã nhập sai';
  }
}

bool validate = false;
dynamic Timkiem(String value) {
  if (validate == false) {
    return null;
  } else if (value.isEmpty) {
    return "Không Được Bỏ Trống Ô";
  }
}

Future<dynamic> getData(
    {String? query, int? status, int? tu, int? den, int? page}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.getString("login");
  List<Products> results = [];
  String myUrl;
  if (den == null && tu == null && query == null && status == null) {
    myUrl = "http://192.168.88.241:8000/api/product/list";
  } else if (den == null &&
      tu == null &&
      query == null &&
      (status == 0 || status == 1)) {
    myUrl = "http://192.168.88.241:8000/api/product/list?is_sales=$status";
  } else if (den == null &&
      tu == null &&
      query != null &&
      (status == 0 || status == 1)) {
    myUrl =
        "http://192.168.88.241:8000/api/product/list?product_name=$query&&is_sales=$status";
  } else if ((tu != null && den != null) &&
      query == null &&
      (status == 0 || status == 1)) {
    myUrl =
        "http://192.168.88.241:8000/api/product/list?from_price=$tu&&to_price=$den";
  } else if (den != null &&
      tu != null &&
      query != null &&
      (status == 0 || status == 1)) {
    myUrl =
        "http://192.168.88.241:8000/api/product/list?is_sales=$status&&from_price=$tu&&to_price=$den&&product_name=$query";
  } else {
    myUrl = "http://192.168.88.241:8000/api/product/list";
  }

  final dio = Dio();
  try {
    var response = await dio
        .get(myUrl,
            options: Options(
              headers: {'Authorization': 'Bearer ${pref.getString("login")}'},
            ))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      results =
          List.from(response.data['products'].map((x) => Products.fromJson(x)));
    } else {
      results =
          List.from(response.data['products'].map((x) => Products.fromJson(x)));
    }
  } on Exception catch (e) {
    print('sadsd $e');
  }
  return results;
}
