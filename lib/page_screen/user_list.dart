import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test2/model/get_data.dart';
import '../controller/edit_textfiled_user.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList>
    with AutomaticKeepAliveClientMixin {
  var ten = TextEditingController();
  final mail = TextEditingController();
  final mk = TextEditingController();
  final mk2 = TextEditingController();
  late TextEditingController tenu;
  late TextEditingController mailu;
  var isSale = 0;
  bool validate = false;
  String dropdownvalue = 'Admin';
  bool isCheck = true;
  bool isCheck1 = false;
  String? tenn;
  String? maill;
  int statuss = 1;
  List<Users> users = [];
  @override
  final items = [
    'Admin',
    'Reviewer',
    'Editor',
  ];
  void clean() {
    ten.clear();
    mail.clear();
    mk.clear();
    mk2.clear();
  }

  @override
  void initState() {
    tenu = TextEditingController(text: '');
    mailu = TextEditingController(text: '');
    super.initState();
  }

  dynamic Timkiem(String value) {
    if (validate == false) {
      return null;
    } else if (value.isEmpty) {
      return "Không Được Bỏ Trống Ô";
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('Images/h1.gif'), fit: BoxFit.cover),
            ),
          ),
          Column(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(9, 15, 10, 20),
                        child: Row(
                          children: [
                            Column(
                              children: const [
                                Text(
                                  'Tên:              ',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18),
                                )
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: ten,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.5, color: Colors.black),
                                      ),
                                      contentPadding: EdgeInsets.all(15),
                                      border: OutlineInputBorder(),
                                      hintText: 'Nhập họ tên',
                                      errorText: Timkiem(ten.text),
                                      labelStyle: TextStyle(
                                        color: Colors.black26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(9, 2, 10, 2),
                        child: Row(
                          children: [
                            Column(
                              children: const [
                                Text(
                                  'Email:           ',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18),
                                )
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: mail,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.5, color: Colors.black),
                                      ),
                                      contentPadding: EdgeInsets.all(15),
                                      border: OutlineInputBorder(),
                                      errorText: Timkiem(mail.text),
                                      hintText: 'Nhập email',
                                      labelStyle: const TextStyle(
                                        color: Colors.black26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      'Trạng thái:  ',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(
                                        'Hoạt Động',
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      value: isCheck,
                                      onChanged: (isCheck1) async {
                                        setState(() => isCheck = isCheck1!);
                                      }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.only(left: 22, top: 2),
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('Images/h3.png'),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            clean();
                                            await showDialog(
                                                context: context,
                                                builder:
                                                    (context) =>
                                                        StatefulBuilder(
                                                          builder: (context,
                                                                  setState) =>
                                                              AlertDialog(
                                                            content:
                                                                SingleChildScrollView(
                                                                    child:
                                                                        Stack(
                                                              overflow: Overflow
                                                                  .visible,
                                                              children: [
                                                                Positioned(
                                                                  right: -40.0,
                                                                  top: -40.0,
                                                                  child:
                                                                      InkResponse(
                                                                    onTap: () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child:
                                                                        const CircleAvatar(
                                                                      child: Icon(
                                                                          Icons
                                                                              .close),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                            width:
                                                                                250,
                                                                            height:
                                                                                50,
                                                                            child:
                                                                                Container(
                                                                              child: Center(
                                                                                child: Text(
                                                                                  'Thêm USER',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.w800,
                                                                                    fontSize: 13,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              color: Colors.blue,
                                                                            )),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.fromLTRB(
                                                                              2,
                                                                              10,
                                                                              10,
                                                                              2),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Column(
                                                                            children: const [
                                                                              Text(
                                                                                'Tên :       ',
                                                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 15),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                TextField(
                                                                                  controller: ten,
                                                                                  style: const TextStyle(color: Colors.black),
                                                                                  decoration: InputDecoration(
                                                                                    enabledBorder: const OutlineInputBorder(
                                                                                      borderSide: BorderSide(width: 1.5, color: Colors.black),
                                                                                    ),
                                                                                    contentPadding: EdgeInsets.all(15),
                                                                                    border: OutlineInputBorder(),
                                                                                    hintText: 'Nhập họ tên',
                                                                                    errorText: validateMT1(ten.text),
                                                                                    labelStyle: TextStyle(
                                                                                      color: Colors.black26,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              2,
                                                                              10,
                                                                              10,
                                                                              2),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Column(
                                                                            children: [
                                                                              Text(
                                                                                'Email:      ',
                                                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 15),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                TextField(
                                                                                  controller: mail,
                                                                                  style: TextStyle(color: Colors.black),
                                                                                  decoration: InputDecoration(
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(width: 1.5, color: Colors.black),
                                                                                    ),
                                                                                    contentPadding: EdgeInsets.all(15),
                                                                                    border: OutlineInputBorder(),
                                                                                    errorText: validateEmail(mail.text),
                                                                                    hintText: 'Nhập email',
                                                                                    labelStyle: TextStyle(
                                                                                      color: Colors.black26,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.fromLTRB(
                                                                              2,
                                                                              10,
                                                                              10,
                                                                              2),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Column(
                                                                            children: [
                                                                              Text(
                                                                                'Mật Khẩu:',
                                                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 15),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                TextField(
                                                                                  controller: mk,
                                                                                  style: TextStyle(color: Colors.black),
                                                                                  decoration: InputDecoration(
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(width: 1.5, color: Colors.black),
                                                                                    ),
                                                                                    contentPadding: EdgeInsets.all(15),
                                                                                    border: OutlineInputBorder(),
                                                                                    hintText: 'Nhập Mật Khẩu',
                                                                                    errorText: validateMT1(mk.text),
                                                                                    labelStyle: TextStyle(
                                                                                      color: Colors.black26,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.fromLTRB(
                                                                              2,
                                                                              10,
                                                                              10,
                                                                              2),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Column(
                                                                            children: const [
                                                                              Text(
                                                                                'Xác Nhận: ',
                                                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 15),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                TextField(
                                                                                  controller: mk2,
                                                                                  style: TextStyle(color: Colors.black),
                                                                                  decoration: InputDecoration(
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(width: 1.5, color: Colors.black),
                                                                                    ),
                                                                                    contentPadding: EdgeInsets.all(15),
                                                                                    border: OutlineInputBorder(),
                                                                                    hintText: 'Xách nhận mật Khẩu',
                                                                                    errorText: validateMT1(mk2.text),
                                                                                    labelStyle: TextStyle(
                                                                                      color: Colors.black26,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.fromLTRB(
                                                                              2,
                                                                              10,
                                                                              10,
                                                                              2),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Column(
                                                                            children: const [
                                                                              Text(
                                                                                'Nhóm:        ',
                                                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 15),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                DropdownButtonFormField(
                                                                                  value: dropdownvalue,
                                                                                  icon: const Icon(
                                                                                    Icons.keyboard_arrow_down,
                                                                                    size: 30,
                                                                                    color: Colors.black87,
                                                                                  ),
                                                                                  items: items.map((String items) {
                                                                                    return DropdownMenuItem(
                                                                                      value: items,
                                                                                      child: Text(items),
                                                                                    );
                                                                                  }).toList(),
                                                                                  onChanged: (String? newValue) {
                                                                                    setState(() {
                                                                                      dropdownvalue = newValue!;
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.fromLTRB(
                                                                              2,
                                                                              10,
                                                                              10,
                                                                              2),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Column(
                                                                            children: [
                                                                              Row(
                                                                                children: const [
                                                                                  Text(
                                                                                    'Trạng thái:  ',
                                                                                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 15),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                CheckboxListTile(
                                                                                    controlAffinity: ListTileControlAffinity.leading,
                                                                                    title: Text(
                                                                                      'Hoạt Động',
                                                                                      style: const TextStyle(
                                                                                        fontSize: 13,
                                                                                      ),
                                                                                    ),
                                                                                    value: isCheck,
                                                                                    onChanged: (isCheck) {
                                                                                      setState(() => this.isCheck = isCheck!);
                                                                                    }),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: RaisedButton(
                                                                                  child: const Text(
                                                                                    "HỦY",
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                  color: Colors.red,
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                            child:
                                                                                Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: RaisedButton(
                                                                                child: const Text(
                                                                                  "LƯU",
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                                onPressed: () {
                                                                                  postData();
                                                                                  setState(() {});
                                                                                },
                                                                                color: Colors.green,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ))
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            )),
                                                          ),
                                                        ));
                                          },
                                          child: const Text(
                                            'Thêm',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 1),
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('Images/h3.png'),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.search,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                validate = true;
                                              });
                                              if (isCheck == true) {
                                                statuss = 1;
                                              } else {
                                                statuss = 0;
                                              }
                                              tenn = ten.text.toString();
                                              maill = mail.text.toString();
                                              setState(() {});
                                            },
                                            child: const Text(
                                              'Tìm kiếm',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('Images/h3.png'),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        clean();
                                        tenn = null;
                                        maill = null;
                                        setState(() {});
                                      },
                                      child: const Text(
                                        'Xóa tìm',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))
                ],
              )),
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: FutureBuilder<dynamic>(
                      future:
                          getData(query: tenn, mail: maill, status: statuss),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          users = snapshot.data as List<Users>;
                          if (users.length < 1) {
                            return const Text(
                              'Không Tìm Thấy Dữ Liệu,Vui Lòng Thử Lại',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w800,
                              ),
                            );
                          }
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(10),
                              itemCount: users.length,
                              itemBuilder: (context, index) {
                                var tt = _Trangthai(users[index].is_active);
                                return Card(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      9, 5, 1, 5),
                                              child: Text(
                                                'Họ Tên:${users[index].name}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  9, 5, 1, 5),
                                              child: Text(
                                                'Email:${users[index].email}',
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  9, 5, 1, 0),
                                              child: Text(
                                                'Trạng Thái:${tt}',
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      9, 10, 1, 10),
                                              child: Text(
                                                'Nhóm:${users[index].group_role}',
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () async {
                                                            clean();
                                                            await showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        StatefulBuilder(
                                                                          builder: (context, setState) =>
                                                                              AlertDialog(
                                                                            content:
                                                                                SingleChildScrollView(
                                                                              child: Expanded(
                                                                                  child: Stack(
                                                                                children: [
                                                                                  Positioned(
                                                                                    right: -40.0,
                                                                                    top: -40.0,
                                                                                    child: InkResponse(
                                                                                      onTap: () {
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                      child: const CircleAvatar(
                                                                                        child: Icon(Icons.close),
                                                                                        backgroundColor: Colors.red,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          SizedBox(
                                                                                              width: 250,
                                                                                              height: 50,
                                                                                              child: Container(
                                                                                                child: Center(
                                                                                                  child: Text(
                                                                                                    'Chỉnh Sửa USERS',
                                                                                                    textAlign: TextAlign.center,
                                                                                                    style: TextStyle(
                                                                                                      color: Colors.white,
                                                                                                      fontWeight: FontWeight.w800,
                                                                                                      fontSize: 13,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                color: Colors.blue,
                                                                                              )),
                                                                                        ],
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(2, 15, 5, 2),
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Column(
                                                                                              children: const [
                                                                                                Text(
                                                                                                  'Họ Tên: ',
                                                                                                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 15),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                            Expanded(
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  TextField(
                                                                                                    controller: tenu = TextEditingController(text: users[index].name),
                                                                                                    style: TextStyle(color: Colors.black),
                                                                                                    decoration: InputDecoration(
                                                                                                      hintText: users[index].name,
                                                                                                      enabledBorder: OutlineInputBorder(
                                                                                                        borderSide: BorderSide(width: 1.5, color: Colors.black),
                                                                                                      ),
                                                                                                      contentPadding: EdgeInsets.all(15),
                                                                                                      errorText: validateMT1(tenu.text),
                                                                                                      border: const OutlineInputBorder(),
                                                                                                      labelStyle: const TextStyle(
                                                                                                        color: Colors.black26,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(2, 5, 5, 2),
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Column(
                                                                                              children: const [
                                                                                                Text(
                                                                                                  'Email:   ',
                                                                                                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 15),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                            Expanded(
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  TextField(
                                                                                                    controller: mailu = TextEditingController(text: users[index].email),
                                                                                                    style: const TextStyle(color: Colors.black),
                                                                                                    decoration: InputDecoration(
                                                                                                      enabledBorder: const OutlineInputBorder(
                                                                                                        borderSide: BorderSide(width: 1.5, color: Colors.black),
                                                                                                      ),
                                                                                                      contentPadding: const EdgeInsets.all(15),
                                                                                                      border: const OutlineInputBorder(),
                                                                                                      hintText: mailu.text,
                                                                                                      errorText: validateEmail(mailu.text),
                                                                                                      labelStyle: const TextStyle(
                                                                                                        color: Colors.black26,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(2, 5, 5, 2),
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Column(
                                                                                              children: const [
                                                                                                Text(
                                                                                                  'Mật Khẩu :',
                                                                                                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 12),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                            Expanded(
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  TextField(
                                                                                                    controller: mk,
                                                                                                    style: const TextStyle(color: Colors.black),
                                                                                                    decoration: InputDecoration(
                                                                                                      enabledBorder: const OutlineInputBorder(
                                                                                                        borderSide: BorderSide(width: 1.5, color: Colors.black),
                                                                                                      ),
                                                                                                      contentPadding: const EdgeInsets.all(15),
                                                                                                      border: const OutlineInputBorder(),
                                                                                                      errorText: validateMT1(mk.text),
                                                                                                      labelStyle: const TextStyle(
                                                                                                        color: Colors.black26,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(2, 5, 5, 2),
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: const [
                                                                                                Text(
                                                                                                  'Xách nhận:',
                                                                                                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 12),
                                                                                                ),
                                                                                                Text(
                                                                                                  'Mật Khẩu:',
                                                                                                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 12),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                            Expanded(
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  TextField(
                                                                                                    controller: mk2,
                                                                                                    style: const TextStyle(color: Colors.black),
                                                                                                    decoration: InputDecoration(
                                                                                                      enabledBorder: const OutlineInputBorder(
                                                                                                        borderSide: BorderSide(width: 1.5, color: Colors.black),
                                                                                                      ),
                                                                                                      contentPadding: const EdgeInsets.all(15),
                                                                                                      border: const OutlineInputBorder(),
                                                                                                      errorText: validateMT1(mk2.text),
                                                                                                      labelStyle: const TextStyle(
                                                                                                        color: Colors.black26,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(2, 10, 10, 2),
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Column(
                                                                                              children: [
                                                                                                Row(
                                                                                                  children: const [
                                                                                                    Text(
                                                                                                      'Nhóm:  ',
                                                                                                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 15),
                                                                                                    ),
                                                                                                  ],
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                            Expanded(
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  DropdownButtonFormField(
                                                                                                    value: dropdownvalue,
                                                                                                    icon: const Icon(
                                                                                                      Icons.keyboard_arrow_down,
                                                                                                      size: 35,
                                                                                                      color: Colors.black87,
                                                                                                    ),
                                                                                                    items: items.map((String items) {
                                                                                                      return DropdownMenuItem(
                                                                                                        value: items,
                                                                                                        child: Text(items),
                                                                                                      );
                                                                                                    }).toList(),
                                                                                                    onChanged: (String? newValue) {
                                                                                                      setState(() {
                                                                                                        dropdownvalue = newValue!;
                                                                                                      });
                                                                                                    },
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Column(
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: RaisedButton(
                                                                                                    child: const Text(
                                                                                                      "HỦY",
                                                                                                      style: TextStyle(color: Colors.white),
                                                                                                    ),
                                                                                                    onPressed: () async {
                                                                                                      Navigator.of(context).pop();
                                                                                                      setState(() {});
                                                                                                    },
                                                                                                    color: Colors.red,
                                                                                                  ),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Column(
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                                  child: RaisedButton(
                                                                                                    child: const Text(
                                                                                                      "LƯU",
                                                                                                      style: TextStyle(color: Colors.white),
                                                                                                    ),
                                                                                                    onPressed: () {
                                                                                                      setState(() {});
                                                                                                      updateData(users[index].id);
                                                                                                      setState(() {});
                                                                                                    },
                                                                                                    color: Colors.green,
                                                                                                  ),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              )),
                                                                            ),
                                                                          ),
                                                                        ));
                                                          },
                                                          icon: const Icon(
                                                            Icons.create,
                                                            size: 30,
                                                          ))
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            deletedata(
                                                                users[index]
                                                                    .id);
                                                            setState(() {});
                                                            print(
                                                                'sdadsad ${users[index].id}');
                                                          },
                                                          icon: const Icon(
                                                            Icons.close,
                                                            size: 30,
                                                          ))
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {});
                                                          if (users[index]
                                                                  .is_active ==
                                                              1) {
                                                            isSale = 0;
                                                          } else {
                                                            isSale = 1;
                                                          }
                                                          lockTK(
                                                              users[index].id,
                                                              isSale);
                                                        },
                                                        child: Icon(
                                                          (users[index]
                                                                      .is_active ==
                                                                  1)
                                                              ? Icons.lock_open
                                                              : Icons.lock,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        }
                        return const Text(
                          'Loanding dữ liệu',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w800,
                          ),
                        );
                      },
                    ),
                  ))
                ],
              ))
            ],
          ),
        ]),
      ),
    );
  }

  _Trangthai(var a) {
    if (a == 1) {
      return 'Hoạt Động';
    } else {
      return 'Đã Khóa';
    }
  }

  Future<dynamic> postData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString("login");

    String myUrl = "http://192.168.88.241:8000/api/user/store";
    Dio dio = Dio();
    var data = {
      "name": ten.text,
      "email": mail.text,
      "group_role": dropdownvalue,
      "is_active": isCheck,
      "password": mk.text,
      "password_confirm": mk2.text,
    };
    var respone = await dio.post(myUrl,
        options: Options(
            headers: {'Authorization': 'Bearer ${pref.getString("login")}'},
            followRedirects: false),
        data: data);
    if (respone.data['status'] == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Lưu Thành Công')));
      Navigator.of(context).pop();
      setState(() {});
      print('Lưu TH Công');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lưu Không Thành Công ${respone.data}')));
      print('Lưu Không KO Công');
      print(respone.data);
    }
  }

  Future<dynamic> deletedata(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString("login");
    String myUrl = "http://192.168.88.241:8000/api/user/delete";
    Dio dio = Dio();
    var response = await dio.delete(myUrl,
        options: Options(
          headers: {'Authorization': 'Bearer ${pref.getString("login")}'},
          followRedirects: false,
        ),
        data: {"id": id});
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Xóa Thành Công')));

      print('ssdadsad $response');
      setState(() {});
      return response;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Xóa Không Thành Công')));
      try {
        Navigator.pop(context);
      } catch (e) {
        return 'HUU';
      }
    }
  }

  Future<dynamic> updateData(var id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString("login");
    String myUrl = "http://192.168.88.241:8000/api/user/update";
    Dio dio = Dio();
    var response = await dio.put(myUrl,
        options: Options(
          headers: {'Authorization': 'Bearer ${pref.getString("login")}'},
          followRedirects: false,
        ),
        data: {
          'id': id,
          "name": tenu.text,
          "email": mailu.text,
          "group_role": dropdownvalue,
          "password": mk.value.text,
          "password_confirm": mk2.value.text,
        });
    if (response.data['status'] == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Lưu Thành Công ')));
      print(response.data);
      Navigator.of(context).pop();
      setState(() {});
      return response.data;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lưu Không Thành Công ${response.data} ')));
      print(response.data);
    }
  }

  Future<dynamic> lockTK(var id, int isSale) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.getString("login");
    String myUrl = "http://192.168.88.241:8000/api/user/update-status";
    Dio dio = Dio();
    var response = await dio.put(myUrl,
        options: Options(
          headers: {'Authorization': 'Bearer ${pref.getString("login")}'},
          followRedirects: false,
        ),
        data: {
          'id': id,
          "is_active": isSale,
        });
    if (response.data['status'] == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Lưu Thành Công ')));
      print(response.data);
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lưu Không Thành Công ${response.data} ')));
      print(response.data);
    }
    return response;
  }

  @override
  bool get wantKeepAlive => true;
}
