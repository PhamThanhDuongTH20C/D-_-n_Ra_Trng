import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test2/page_screen/login.dart';
import 'package:test2/page_screen/task.dart';

class WaittingLogin extends StatefulWidget {
  const WaittingLogin({Key? key}) : super(key: key);

  @override
  State<WaittingLogin> createState() => _WaittingLoginState();
}

class _WaittingLoginState extends State<WaittingLogin> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("login");

    if (val != null) {
      Timer(Duration(seconds: 4), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const TaskHome()),
            (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Chào Mừng Bạn Quay Lại!!!')));
      });
    } else {
      Timer(Duration(seconds: 4), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Images/oc.gif'),
          ),
        ),
      ),
    );
  }
}
