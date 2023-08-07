import 'package:flutter/material.dart';
import 'package:test2/page_screen/login.dart';
import 'customer.dart';
import 'product_list.dart';
import 'user_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskHome extends StatefulWidget {
  const TaskHome();

  @override
  State<TaskHome> createState() => _TaskHomeState();
}

class _TaskHomeState extends State<TaskHome> {
  int currentIndex = 0;

  String? name = '';
  final Screen = [
    const ProductList(),
    const Customer(),
    const UserList(),
  ];

  @override
  void initiState() async {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          /*   leading: InkWell(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.group,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '$name',
                  style: TextStyle(fontSize: 8, color: Colors.black),
                )
              ],
            ),
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              name = pref.getString("name");
              print('asdsad $name');
              setState(() {});
            },
          ),*/
          actions: [
            InkWell(
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.input,
                      size: 28,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                await pref.clear();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Login()),
                    (route) => false);
                print('sss + ${pref.getString("login")}');
              },
            ),
          ],
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'HOME',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              )
            ],
          )),
      body: Screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) => setState(() => currentIndex = index),
          currentIndex: currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          selectedFontSize: 16,
          unselectedFontSize: 11,
          backgroundColor: Colors.blue,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.photo),
              label: 'SẢN PHẨM',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'KHÁCH HÀNG',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add),
              label: 'USERS',
            )
          ]),
    );
  }
}
