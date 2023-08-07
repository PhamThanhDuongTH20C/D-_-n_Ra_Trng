import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/customer.dart';

dynamic validateMT(String txt) {
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

dynamic validateEmail(String value) {
  try {
    if (value.isEmpty) {
      return "Không được BỎ TRỐNG";
    } else if (value.isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return "Email abc@gmail.com";
    } else {
      return null;
    }
  } catch (e) {
    return 'Email:abc@gmail.com';
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

bool validate = false;
dynamic Timkiem(String value) {
  if (validate == false) {
    return null;
  } else if (value.isEmpty) {
    return "Không Được Bỏ Trống Ô";
  }
}

Future<dynamic> getData({
  String? query,
  int? status,
  String? email,
}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.getString("login");
  String myUrl;
  List<Customers> results = [];
  if (query == null && email == null) {
    myUrl = "http://192.168.88.241:8000/api/customer/list";
  } else if (query == null && email == null && (status == 1 || status == 0)) {
    myUrl = "http://192.168.88.241:8000/api/customer/list?is_active=$status";
  } else if (query == null && email == null && query != null) {
    myUrl =
        "http://192.168.88.241:8000/api/customer/list?is_active=$status&&product_name=$query";
  } else if (query == null && email == null && email != null) {
    myUrl =
        "http://192.168.88.241:8000/api/customer/list?is_active=$status&&email=$email";
  } else {
    myUrl =
        "http://192.168.88.241:8000/api/customer/list?is_active=$status&&product_name=$query&&email=$email";
  }
  final dio = Dio();
  try {
    var response = await dio.get(myUrl,
        options: Options(
            headers: {'Authorization': 'Bearer ${pref.getString("login")}'},
            followRedirects: false));
    if (response.statusCode == 200) {
      results = List.from(
          response.data['customers'].map((x) => Customers.fromJson(x)));
      if (query != null && status != null) {
        results = results
            .where((element) => (element.customerName!
                .toLowerCase()
                .contains((query.toLowerCase()))))
            .toList();
      }
    } else {
      results = List.from(
          response.data['customers'].map((x) => Customers.fromJson(x)));
    }
  } on Exception catch (e) {
    print('asdsad $e');
  }
  return results;
}
