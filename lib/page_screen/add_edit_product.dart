import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test2/controller/edit_textfiled_product.dart';
import 'package:test2/page_screen/task.dart';
import '../controller/edit_textfiled_product.dart';

class AddProoduct extends StatefulWidget {
  const AddProoduct({Key? key}) : super(key: key);

  @override
  State<AddProoduct> createState() => _AddProoductState();
}

class _AddProoductState extends State<AddProoduct> {
  bool isCheck = true;
  var isSale = '';
  bool validate = false;

  // Implementing the image picker
  File? _image;
  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
    print('sss $_image');
  }

  @override
  void initState() {
    super.initState();
  }

  var tensp = TextEditingController();
  var gia = TextEditingController();
  final mota = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Thêm sản phẩm',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Row(
                  children: [
                    Column(
                      children: const [
                        Text(
                          'Tên sản phẩm:',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextField(
                            controller: tensp,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.5, color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.all(14),
                              border: const OutlineInputBorder(),
                              hintText: 'Nhập tên sản phẩm',
                              errorText: validateTP(tensp.text),
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
                padding: const EdgeInsets.fromLTRB(10, 1, 10, 5),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Giá bán:            ',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: gia,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.5, color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.all(14),
                              border: OutlineInputBorder(),
                              hintText: 'Nhập giá bán',
                              errorText: validateGia(gia.text),
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
                padding: const EdgeInsets.fromLTRB(10, 1, 10, 5),
                child: Row(
                  children: [
                    Column(
                      children: const [
                        Text(
                          'Mô tả:               ',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextField(
                            controller: mota,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.5, color: Colors.black),
                              ),
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(60),
                              hintText: 'Mô tả sản phẩm',
                              errorText: validateMT(mota.text),
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
                padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Trạng thái:       ',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        )
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              isCheck ? 'Còn Hàng ' : 'Hết Hàng',
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            value: isCheck,
                            onChanged: (isCheck) async {
                              print('sssssssssss $isCheck');
                              {
                                if (isCheck == false) {
                                  isSale = "0";
                                } else {
                                  isSale = "1";
                                }
                              }
                              print('sssssdsadasdas $_image');
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 1, 1, 1),
                child: Row(
                  children: [
                    Column(
                      children: const [
                        Text(
                          'Hình ảnh:        ',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: _openImagePicker,
                          child: const Image(
                            image: AssetImage(
                              'Images/h5.png',
                            ),
                            width: 120,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 1, 5, 10),
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      child: _image != null
                          ? Image.file(_image!, fit: BoxFit.cover)
                          : const Image(
                              image: NetworkImage(
                                  'https://lh4.ggpht.com/-PtwFBckvv78/V3aBB39xD9I/AAAAAAAAHFA/EXKKalIB8IkvyJjUzGrDVQCzLMs5Alx9QCLcB/s1600/anh-blogspot-khong-hien-thi.png')),
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(1, 1, 15, 3),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width / 2.5,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('Images/h7.png'),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                              child: const Text(
                                'HỦY',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 5),
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('Images/h8.png'),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                validate = true;
                              });
                              postData();
                              if (_image == null ||
                                  tensp.value.text.isEmpty ||
                                  gia.value.text.isEmpty ||
                                  mota.value.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Bạn vui lòng nhập thông tin Sản Phẩm')));
                              }
                              setState(() {});
                            },
                            child: const Text(
                              'LƯU',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              )
            ],
          )
        ]),
      ),
    );
  }

  Future postData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString("login");
    String fileName = _image!.path.split('/').last;

    var data = FormData.fromMap({
      "product_image": await MultipartFile.fromFile(
        _image!.path,
        filename: fileName,
      ),
      'product_name': tensp.text,
      'product_price': gia.text,
      'is_sales': 1,
      'description': mota.text,
    });

    String myUrl = "http://192.168.88.241:8000/api/product/store";
    Dio dio = Dio();

    var respone = await dio.post(myUrl,
        options: Options(
            headers: {'Authorization': 'Bearer ${pref.getString("login")}'},
            followRedirects: false),
        data: data);
    if (respone.data['status'] == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Lưu Thành Công ')));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TaskHome()));
      setState(() {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${respone}')));
    }
    return respone;
  }
}
