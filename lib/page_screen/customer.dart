// ignore_for_file: deprecated_member_use
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/edit_textfiled_customer.dart';
import '../model/customer.dart';

class Customer extends StatefulWidget {
  const Customer({Key? key}) : super(key: key);

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  late TextEditingController tenn;
  late TextEditingController maill;
  late TextEditingController sdtt;
  late TextEditingController diachii;
  List<Customers> list = [];
  final ten = TextEditingController();
  final mail = TextEditingController();
  final sdt = TextEditingController();
  final diachi = TextEditingController();
  @override
  String? email;
  String? query;
  int? status;
  String dropdownvalue = 'Hoạt động';
  bool isCheck = false;
  bool isCheck1 = true;
  // List of items in our dropdown menu
  int? isSale;
  var items = [
    'Hoạt động',
    'Đã Khóa',
  ];
  void clean() {
    ten.clear();
    diachi.clear();
    mail.clear();
    sdt.clear();
  }

  @override
  void initState() {
    tenn = TextEditingController(text: "");
    maill = TextEditingController(text: "");
    sdtt = TextEditingController(text: "");
    diachii = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 2),
                        child: Row(
                          children: [
                            Column(
                              children: const [
                                Text(
                                  'Họ và Tên:   ',
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
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.5, color: Colors.black),
                                      ),
                                      contentPadding: const EdgeInsets.all(15),
                                      border: const OutlineInputBorder(),
                                      hintText: 'Nhập họ tên',
                                      errorText: Timkiem(ten.text),
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
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.5, color: Colors.black),
                                      ),
                                      contentPadding: const EdgeInsets.all(15),
                                      border: const OutlineInputBorder(),
                                      hintText: 'Nhập email',
                                      errorText: Timkiem(mail.text),
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
                                      'Trạng thái:   ',
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
                                  DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.5, color: Colors.black),
                                      ),
                                      border: OutlineInputBorder(),
                                      labelStyle: TextStyle(
                                        color: Colors.black26,
                                      ),
                                      contentPadding: EdgeInsets.all(14),
                                    ),
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
                                              builder: (context) =>
                                                  StatefulBuilder(
                                                builder: (context, setState) =>
                                                    AlertDialog(
                                                  content:
                                                      SingleChildScrollView(
                                                          child: Stack(
                                                    overflow: Overflow.visible,
                                                    children: [
                                                      Positioned(
                                                        right: -40.0,
                                                        top: -40.0,
                                                        child: InkResponse(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const CircleAvatar(
                                                            child: Icon(
                                                                Icons.close),
                                                            backgroundColor:
                                                                Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                  width: 250,
                                                                  height: 50,
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        'Thêm Khách Hàng',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.w800,
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    color: Colors
                                                                        .blue,
                                                                  )),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    2,
                                                                    10,
                                                                    10,
                                                                    2),
                                                            child: Row(
                                                              children: [
                                                                Column(
                                                                  children: const [
                                                                    Text(
                                                                      'Họ và Tên : ',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight: FontWeight
                                                                              .w900,
                                                                          fontSize:
                                                                              15),
                                                                    )
                                                                  ],
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    children: [
                                                                      TextField(
                                                                        controller:
                                                                            ten,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                        decoration:
                                                                            InputDecoration(
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(width: 1.5, color: Colors.black),
                                                                          ),
                                                                          contentPadding:
                                                                              EdgeInsets.all(15),
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          hintText:
                                                                              'Nhập họ tên',
                                                                          errorText:
                                                                              validateMT(ten.text),
                                                                          labelStyle:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black26,
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
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    2,
                                                                    10,
                                                                    10,
                                                                    2),
                                                            child: Row(
                                                              children: [
                                                                Column(
                                                                  children: const [
                                                                    Text(
                                                                      'Email:          ',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight: FontWeight
                                                                              .w900,
                                                                          fontSize:
                                                                              15),
                                                                    )
                                                                  ],
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    children: [
                                                                      TextField(
                                                                        controller:
                                                                            mail,
                                                                        keyboardType:
                                                                            TextInputType.emailAddress,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                        decoration:
                                                                            InputDecoration(
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(width: 1.5, color: Colors.black),
                                                                          ),
                                                                          contentPadding:
                                                                              EdgeInsets.all(15),
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          errorText:
                                                                              validateEmail(mail.text),
                                                                          hintText:
                                                                              'Nhập email',
                                                                          labelStyle:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black26,
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
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    2,
                                                                    10,
                                                                    10,
                                                                    2),
                                                            child: Row(
                                                              children: [
                                                                Column(
                                                                  children: const [
                                                                    Text(
                                                                      'Điện thoại:  ',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight: FontWeight
                                                                              .w900,
                                                                          fontSize:
                                                                              15),
                                                                    )
                                                                  ],
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    children: [
                                                                      TextField(
                                                                        controller:
                                                                            sdt,
                                                                        keyboardType:
                                                                            TextInputType.number,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                        decoration:
                                                                            InputDecoration(
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(width: 1.5, color: Colors.black),
                                                                          ),
                                                                          contentPadding:
                                                                              EdgeInsets.all(15),
                                                                          border:
                                                                              const OutlineInputBorder(),
                                                                          errorText:
                                                                              validateGia(sdt.text),
                                                                          hintText:
                                                                              'Nhập số điện thoại',
                                                                          labelStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Colors.black26,
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
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    2,
                                                                    10,
                                                                    10,
                                                                    2),
                                                            child: Row(
                                                              children: [
                                                                Column(
                                                                  children: const [
                                                                    Text(
                                                                      'Địa chỉ:        ',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight: FontWeight
                                                                              .w900,
                                                                          fontSize:
                                                                              15),
                                                                    )
                                                                  ],
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    children: [
                                                                      TextField(
                                                                        controller:
                                                                            diachi,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                        decoration:
                                                                            InputDecoration(
                                                                          enabledBorder:
                                                                              const OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(width: 1.5, color: Colors.black),
                                                                          ),
                                                                          contentPadding:
                                                                              const EdgeInsets.all(15),
                                                                          border:
                                                                              const OutlineInputBorder(),
                                                                          hintText:
                                                                              'Nhập địa chỉ',
                                                                          errorText:
                                                                              validateMT(diachi.text),
                                                                          labelStyle:
                                                                              const TextStyle(
                                                                            color:
                                                                                Colors.black26,
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
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    2,
                                                                    10,
                                                                    10,
                                                                    2),
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
                                                                              fontSize: 15),
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
                                                                        title:
                                                                            Text(
                                                                          'Hoạt Động',
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                          ),
                                                                        ),
                                                                        value:
                                                                            isCheck,
                                                                        onChanged:
                                                                            (isCheck) =>
                                                                                setState(() => this.isCheck = isCheck!),
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
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          RaisedButton(
                                                                        child:
                                                                            const Text(
                                                                          "HỦY",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        RaisedButton(
                                                                      child:
                                                                          const Text(
                                                                        "LƯU",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {});
                                                                        postData();
                                                                      },
                                                                      color: Colors
                                                                          .green,
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
                                              ),
                                            );
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
                                          left: 18, bottom: 2),
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
                                            size: 19,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                validate = true;
                                              });
                                              if (dropdownvalue ==
                                                  'Hoạt động') {
                                                status = 1;
                                              } else {
                                                status = 0;
                                              }
                                              query = ten.text.toString();
                                              email = mail.text.toString();
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
                                        query = null;
                                        email = null;
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
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 12, top: 2),
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('Images/h3.png'),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.vertical_align_bottom,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    ' Export',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
                        child: FutureBuilder(
                            future: getData(
                              query: query,
                              status: status,
                              email: email,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<Customers> customers =
                                    snapshot.data as List<Customers>;
                                if (customers.length < 1) {
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(10),
                                    itemCount: customers.length,
                                    itemBuilder: (context, index) {
                                      var tt =
                                          _Trangthai(customers[index].isActive);
                                      return Card(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 9, 0, 2),
                                                    child: Text(
                                                      'Họ Tên:${customers[index].customerName}',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 2, 0, 2),
                                                    child: Text(
                                                      'Địa Chỉ:${customers[index].address}',
                                                      style: const TextStyle(
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 2, 0, 2),
                                                    child: Text(
                                                      'Email:${customers[index].email}',
                                                      style: const TextStyle(
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 2, 0, 2),
                                                    child: Text(
                                                      'Điện thoại:${customers[index].telNum}',
                                                      style: const TextStyle(
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 2, 0, 9),
                                                    child: Text(
                                                      'Trạng thái: $tt',
                                                      style: const TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              clean();
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      StatefulBuilder(
                                                                        builder:
                                                                            (context, setState) =>
                                                                                AlertDialog(
                                                                          content:
                                                                              SingleChildScrollView(
                                                                            child: Expanded(
                                                                                child: Stack(
                                                                              overflow: Overflow.visible,
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
                                                                                  mainAxisSize: MainAxisSize.min,
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
                                                                                                  'Chỉnh Sửa Khách Hàng',
                                                                                                  textAlign: TextAlign.center,
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.white,
                                                                                                    fontWeight: FontWeight.w800,
                                                                                                    fontSize: 15,
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
                                                                                                  controller: tenn = TextEditingController(text: customers[index].customerName),
                                                                                                  style: const TextStyle(color: Colors.black),
                                                                                                  decoration: InputDecoration(
                                                                                                    enabledBorder: const OutlineInputBorder(
                                                                                                      borderSide: BorderSide(width: 1.5, color: Colors.black),
                                                                                                    ),
                                                                                                    contentPadding: const EdgeInsets.all(15),
                                                                                                    border: const OutlineInputBorder(),
                                                                                                    errorText: validateMT(tenn.text),
                                                                                                    hintText: tenn.text,
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
                                                                                                'Địa chỉ: ',
                                                                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 15),
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Column(
                                                                                              children: [
                                                                                                TextField(
                                                                                                  controller: diachii = TextEditingController(text: customers[index].address),
                                                                                                  style: const TextStyle(color: Colors.black),
                                                                                                  decoration: InputDecoration(
                                                                                                    enabledBorder: const OutlineInputBorder(
                                                                                                      borderSide: BorderSide(width: 1.5, color: Colors.black),
                                                                                                    ),
                                                                                                    contentPadding: const EdgeInsets.all(15),
                                                                                                    border: const OutlineInputBorder(),
                                                                                                    errorText: validateMT(diachii.text),
                                                                                                    hintText: diachii.text,
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
                                                                                                'Email:   ',
                                                                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 15),
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Column(
                                                                                              children: [
                                                                                                TextField(
                                                                                                  controller: maill = TextEditingController(text: customers[index].email),
                                                                                                  style: const TextStyle(color: Colors.black),
                                                                                                  decoration: InputDecoration(
                                                                                                    enabledBorder: const OutlineInputBorder(
                                                                                                      borderSide: BorderSide(width: 1.5, color: Colors.black),
                                                                                                    ),
                                                                                                    contentPadding: const EdgeInsets.all(15),
                                                                                                    border: const OutlineInputBorder(),
                                                                                                    hintText: maill.text,
                                                                                                    errorText: validateEmail(maill.text),
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
                                                                                                'Điện Thoại: ',
                                                                                                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 15),
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Column(
                                                                                              children: [
                                                                                                TextField(
                                                                                                  controller: sdtt = TextEditingController(text: customers[index].telNum),
                                                                                                  keyboardType: TextInputType.number,
                                                                                                  style: const TextStyle(color: Colors.black),
                                                                                                  decoration: InputDecoration(
                                                                                                    enabledBorder: const OutlineInputBorder(
                                                                                                      borderSide: BorderSide(width: 1.5, color: Colors.black),
                                                                                                    ),
                                                                                                    contentPadding: const EdgeInsets.all(15),
                                                                                                    border: const OutlineInputBorder(),
                                                                                                    hintText: sdtt.text,
                                                                                                    errorText: validateGia(sdtt.text),
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
                                                                                                  updateData(customers[index].customerId, customers[index].isActive);
                                                                                                  Navigator.of(context).pop();
                                                                                                },
                                                                                                color: Colors.green,
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ))
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
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 9),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {});
                                                                if (customers[
                                                                            index]
                                                                        .isActive ==
                                                                    1) {
                                                                  isSale = 0;
                                                                } else {
                                                                  isSale = 1;
                                                                }
                                                                lockTK(
                                                                    customers[
                                                                            index]
                                                                        .customerId,
                                                                    customers[
                                                                            index]
                                                                        .customerName,
                                                                    customers[
                                                                            index]
                                                                        .email,
                                                                    customers[
                                                                            index]
                                                                        .telNum,
                                                                    customers[
                                                                            index]
                                                                        .address,
                                                                    isSale);

                                                                setState(() {});
                                                              },
                                                              child: Icon(
                                                                (customers[index]
                                                                            .isActive ==
                                                                        1)
                                                                    ? Icons
                                                                        .lock_open
                                                                    : Icons
                                                                        .lock,
                                                                size: 30,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
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
                            })),
                  )
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

  Future updateData(var id, int? ad) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString("login");
    String myUrl = "http://192.168.88.241:8000/api/customer/update?";
    Dio dio = Dio();
    var response = await dio.put(myUrl,
        options: Options(
          headers: {'Authorization': 'Bearer ${pref.getString("login")}'},
          followRedirects: false,
        ),
        data: {
          "customer_id": id,
          "customer_name": tenn.text,
          "email": maill.text,
          "tel_num": sdtt.text,
          "address": diachii.text,
          "is_active": ad,
        });
    if (response.data['status'] == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Lưu Thành Công ')));
      setState(() {});
      print(response.data);
      return response.data;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lưu Không Thành Công ${response.data} ')));
      print(response.data);
    }
  }

  Future lockTK(var id, var ten, var mail, var tel, var adrr, var isla) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString("login");
    String myUrl = "http://192.168.88.241:8000/api/customer/update";
    Dio dio = Dio();
    var response = await dio.put(myUrl,
        options: Options(
          headers: {'Authorization': 'Bearer ${pref.getString("login")}'},
          followRedirects: false,
        ),
        data: {
          "customer_id": id,
          "customer_name": ten,
          "email": mail,
          "tel_num": tel,
          "address": adrr,
          "is_active": isla,
        });
    if (response.data['status'] == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Lưu Thành Công ')));
      print('asda $response');
      setState(() {});
    }
    return response;
  }

  Future postData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString("login");

    String myUrl = "http://192.168.88.241:8000/api/customer/store";
    Dio dio = Dio();
    var data = {
      "customer_name": ten.text,
      "email": mail.text,
      "tel_num": sdt.text,
      "address": diachi.text,
      "is_active": isCheck,
    };
    var respone = await dio.post(myUrl,
        options: Options(
            headers: {'Authorization': 'Bearer ${pref.getString("login")}'},
            followRedirects: false),
        data: data);
    if (respone.data['status'] == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Lưu Thành Công')));
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lưu Không Thành Công ${respone.data} ')));
      print('Lưu Không KO Công');
      print(respone.data);
    }
  }
}
