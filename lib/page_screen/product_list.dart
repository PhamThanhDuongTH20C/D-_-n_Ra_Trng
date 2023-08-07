// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test2/model/product_model.dart';
import '../controller/edit_textfiled_product.dart';
import 'add_edit_product.dart';
import 'edit_product.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>
    with AutomaticKeepAliveClientMixin {
  List<Products> products = [];
  int page = 1;
  String dropdownvalue = 'Còn Hàng';
  int? status;
  int? statuss;
  bool isCheck = true;
  bool isLoadingMore = false;
  int? tu;
  int? den;
  final scrollController1 = ScrollController();
  final scrollController = ScrollController();
  var items = [
    'Còn Hàng',
    'Hết Hàng',
  ];
  var tut = TextEditingController();
  var denn = TextEditingController();
  final ten = TextEditingController();
  final gia = TextEditingController();
  var timkiem = TextEditingController();
  String? query;
  int xoa = 0;
  List<Products> list = [];
  @override
  void clearText() {
    timkiem.clear();
    tut.clear();
    ten.clear();
    gia.clear();
    denn.clear();
  }

  @override
  void initState() {
    super.initState();
    scrollController1.addListener(scrolllistener);
    getData(page: page).then((datafrom) {
      setState(() {
        products = products + datafrom;
      });
    });
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
            children: <Widget>[
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 1),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  'Tên sản phẩm: ',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w900),
                                )
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 75,
                                    child: TextField(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      controller: timkiem,
                                      decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5, color: Colors.black),
                                        ),
                                        border: const OutlineInputBorder(),
                                        hintText: 'Nhập tên sản phẩm',
                                        errorText: Timkiem(timkiem.text),
                                        labelStyle: const TextStyle(
                                          color: Colors.black26,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      ' Trạng thái:       ',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    child: DropdownButtonFormField(
                                      decoration: const InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5, color: Colors.black),
                                        ),
                                        border: OutlineInputBorder(),
                                        labelStyle: TextStyle(
                                          color: Colors.black26,
                                        ),
                                      ),
                                      value: dropdownvalue,
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 30,
                                        color: Colors.black87,
                                      ),
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                            items,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      },
                                    ),
                                    height: 58,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 1, 5, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  ' Giá bán:            ',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w900),
                                )
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                      child: TextField(
                                        controller: tut,
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        decoration: InputDecoration(
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.black),
                                            ),
                                            border: const OutlineInputBorder(),
                                            hintText: 'Từ ',
                                            errorText: Timkiem(tut.text),
                                            labelStyle: const TextStyle(
                                              color: Colors.black26,
                                            )),
                                      ),
                                      height: 70)
                                ],
                              ),
                            ),
                            Column(
                              children: const [
                                Text(
                                  '-',
                                  style: TextStyle(fontSize: 40),
                                )
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    child: TextField(
                                      controller: denn,
                                      keyboardType: TextInputType.number,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color: Colors.black),
                                          ),
                                          border: const OutlineInputBorder(),
                                          hintText: 'Đến',
                                          errorText: Timkiem(denn.text),
                                          labelStyle: const TextStyle(
                                            color: Colors.black26,
                                          )),
                                    ),
                                    height: 70,
                                  )
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
                                      padding: const EdgeInsets.only(
                                          left: 22, bottom: 2),
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              7,
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
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const AddProoduct()));
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
                                      )),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 2),
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              7,
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
                                            size: 20,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                validate = true;
                                              });
                                              if (dropdownvalue == 'Còn Hàng') {
                                                statuss = 1;
                                              } else {
                                                statuss = 0;
                                              }
                                              print('asd $statuss');
                                              query = timkiem.text.toString();
                                              status = statuss;
                                              tu = int.parse(tut.text);
                                              den = int.parse(denn.text);
                                              print('asdasd $status');
                                              setState(() {});
                                            },
                                            child: const Text(
                                              'Tìm kiếm',
                                              style: TextStyle(
                                                  fontSize: 18,
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
                                    height:
                                        MediaQuery.of(context).size.height / 7,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('Images/h3.png'),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        clearText();
                                        query = null;
                                        status = null;
                                        den = null;
                                        tu = null;
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
                            )
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
                    controller: scrollController1,
                    child: FutureBuilder(
                        future: getData(
                            query: query,
                            status: status,
                            tu: tu,
                            den: den,
                            page: page),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            products = snapshot.data as List<Products>;
                            if (products.length < 1) {
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
                                controller: scrollController,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(5),
                                itemCount: products.length,
                                itemBuilder: (context, int index) {
                                  var ppro = products[index];
                                  var tt = _Trangthai(products[index].isSales);
                                  return SingleChildScrollView(
                                    child: Card(
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Image(
                                                  image: NetworkImage(
                                                      '${products[index].image}'),
                                                  width: 100,
                                                  height: 90,
                                                ),
                                              )
                                            ],
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          1, 8, 1, 0),
                                                  child: Text(
                                                    'Tên: ${products[index].productName}',
                                                    style: const TextStyle(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(1, 1, 1, 0),
                                                    child: Row(
                                                      children: [
                                                        const Text("Giá:"),
                                                        Text(
                                                          '${products[index].productPrice}'
                                                              .toVND(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14),
                                                        ),
                                                      ],
                                                    )),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          1, 25, 1, 8),
                                                  child: Text(
                                                    'Trình Trạng: ${tt}',
                                                    style: const TextStyle(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          EditAddUser(
                                                                              ppro: ppro)));
                                                            },
                                                            icon: const Icon(
                                                              Icons.create,
                                                              size: 25,
                                                            ))
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              /////////////////////////
                                                              deletedata(products[
                                                                      index]
                                                                  .productId
                                                                  .toString());
                                                              setState(() {});
                                                            },
                                                            icon: const Icon(
                                                              Icons.close,
                                                              size: 35,
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
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
                        }),
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
      return 'Còn Hàng';
    } else {
      return 'Hết Hàng';
    }
  }

  Future<dynamic> deletedata(var id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString("login");
    String myUrl = "http://192.168.88.241:8000/api/product/delete";
    Dio dio = Dio();
    var response = await dio.delete(myUrl,
        options: Options(
          headers: {'Authorization': 'Bearer ${pref.getString("login")}'},
          followRedirects: false,
        ),
        data: {"product_id": id});
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Xóa Thành Công')));
      setState(() {});
      print('ssdadsad $response');
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

  Future<void> scrolllistener() async {
    if (scrollController1.position.pixels ==
        scrollController1.position.maxScrollExtent) {
      page = page + 1;
      final mangpro = await getData(page: page);
      print(' sds  ${mangpro.length}');
      if (mangpro.length > 0) {
        setState(() {
          products = products + mangpro;
        });
      }

         print('Cham Dai page XH1 $page');
      print('Cham Dai XH12 ${products.length}');
    }
  }

  @override
  bool get wantKeepAlive => true;
}
