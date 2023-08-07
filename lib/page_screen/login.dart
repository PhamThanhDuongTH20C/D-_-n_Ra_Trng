import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test2/model/user_model.dart';
import 'task.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  void clean() {}
  final txtTaikhoan = TextEditingController();
  final txtPass = TextEditingController();
  Icon iconshow = const Icon(Icons.visibility_off);
  bool ishiden = true;
  bool validate = false;
  bool isChecked = false;
  bool islogin = false;
  dynamic validatePassword(String value) {
    if (validate == false) {
      return null;
    } else if (value.isEmpty) {
      return "Mật Khẩu không được BỎ TRỐNG";
    }
  }

  dynamic validateEmail(String value) {
    if (validate == false) {
      return null;
    } else if (value.isEmpty) {
      return "Tài Khoản kkhông được BỎ TRỐNG";
    } else if (value.isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return "Bạn Hãy Nhập Email Với định dạng abc@gmail.com";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'LOGIN',
              style: TextStyle(
                  color: Colors.red, fontSize: 24, fontWeight: FontWeight.w700),
            )
          ],
        )),
        body: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('Images/h1.gif'), fit: BoxFit.cover),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage('Images/h2.png'),
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 4,
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Color.fromARGB(255, 232, 2, 2),
                        fontWeight: FontWeight.w900,
                        fontSize: 40),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: txtTaikhoan,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: Colors.black),
                        ),
                        border: const OutlineInputBorder(),
                        labelText: 'Login',
                        errorText: validateEmail(txtTaikhoan.text),
                        prefixIcon: const Icon(
                          Icons.group,
                          color: Colors.black,
                          size: 18,
                        ),
                        labelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 20),
                  child: TextField(
                    controller: txtPass,
                    obscureText: ishiden,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: Colors.black),
                        ),
                        border: const OutlineInputBorder(),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              ishiden = !ishiden;
                            });
                            if (ishiden) {
                              setState(() {
                                iconshow = const Icon(Icons.visibility_off);
                              });
                            } else {
                              setState(() {
                                iconshow = const Icon(Icons.visibility);
                              });
                            }
                          },
                          child: iconshow,
                        ),
                        labelText: 'Password',
                        errorText: validatePassword(txtPass.text),
                        prefixIcon: const Icon(
                          Icons.remove_red_eye,
                          color: Colors.black,
                          size: 18,
                        ),
                        labelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width / 1.75,
                      height: MediaQuery.of(context).size.height / 9,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('Images/h3.png'),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          setState(() {
                            validate = true;
                          });
                          if (txtPass.toString().isNotEmpty &&
                              txtTaikhoan.toString().isNotEmpty) {
                            login();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Hay dien MK va TK')));
                          }
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ]));
  }

  Future<void> login() async {
    final dio = Dio();
    final respone = await dio
        .post('http://192.168.88.241:8000/api/login', queryParameters: {
      'email': txtTaikhoan.text,
      'password': txtPass.text,
    });

    if (respone.data['status'] == 200) {
      final User user = User.fromJson(respone.data);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Đăng Nhập Thành Công')));
      print('dataaaa ' + user.accessToken.toString());
      print('dataaaa ' + user.email.toString());
      print('ssss ${respone}');
      pageRoute(user);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sai Mật Khẩu hoặc Tài Khoản')));
    }
  }

  void pageRoute(user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("login", user.accessToken.toString());
    await pref.setString("name", user.name.toString());
    String a = txtPass.value.text;
    await pref.setString("password", a);
    String? obtained = pref.getString('login');

    print('ssss +${user.accessToken.toString()}');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => TaskHome()), (route) => false);
  }
}
