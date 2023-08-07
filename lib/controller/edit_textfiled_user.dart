import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/get_data.dart';

dynamic validateMT(String txt, String tst) {
  try {
    if (txt.isEmpty) {
      return "Không được BỎ TRỐNG";
    }
    if (txt != tst) {
      return 'Mật Khẩu Không Trùng';
    } else {
      return null;
    }
  } catch (e) {
    return 'Đừng bỏ Trống Ô';
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

dynamic validateMT1(String txt) {
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

dynamic validateEmail(String value) {
  try {
    if (value.isEmpty) {
      return "Không được BỎ TRỐNG";
    } else if (value.isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return "Email abc@gmail.com";
    }
  } catch (e) {
    return 'Email:abc@gmail.com';
  }
}

Future<dynamic> getData({String? query, String? mail, int? status}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.getString("login");
  List<Users> results = [];
  String myUrl;
  if (query == null && mail == null) {
    myUrl = "http://192.168.88.241:8000/api/user/list";
  } else {
    myUrl =
        "http://192.168.88.241:8000/api/user/list?is_active=$status&email=$mail";
  }
  final dio = Dio();
  try {
    var response = await dio.get(myUrl,
        options: Options(
            headers: {'Authorization': 'Bearer ${pref.getString("login")}'},
            followRedirects: false));

    if (response.statusCode == 200) {
      results = List.from(response.data['users'].map((x) => Users.fromJson(x)));
      if (query != null && status != null) {
        results = results
            .where((element) =>
                (element.name.toLowerCase().contains((query.toLowerCase()))))
            .toList();
      }
    } else {
      results = List.from(response.data['users'].map((x) => Users.fromJson(x)));
    }
  } on Exception catch (e) {
    print('sssdas $e');
  }
  return results;
}
