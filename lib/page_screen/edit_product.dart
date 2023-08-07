import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test2/controller/edit_textfiled_product.dart';
import 'package:test2/page_screen/product_list.dart';
import '../controller/edit_textfiled_product.dart';
import '../model/product_model.dart';
import 'task.dart';

class EditAddUser extends StatefulWidget {
  const EditAddUser({required this.ppro});
  final Products ppro;
  @override
  State<EditAddUser> createState() => _EditAddUserState();
}

class _EditAddUserState extends State<EditAddUser> {
  bool isCheck = true;
  int isSale = 1;
  bool validate = false;

  // List of items in our dropdown menu

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
    } else {
      _image == null;
    }
    print('sss $_image');
  }

  List<ProductList> productss = [];
  late TextEditingController tensp;
  late TextEditingController gia;
  late TextEditingController mota;
  var _tensp;
  var _gia;
  var _mota;

  @override
  void initState() {
    gia = TextEditingController(text: widget.ppro.productPrice);
    tensp = TextEditingController(text: widget.ppro.productName);
    mota = TextEditingController(text: widget.ppro.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Sửa sản phẩm',
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
                            color: Colors.black87, fontWeight: FontWeight.w900),
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
                            hintText: tensp.text,
                            errorText: validateTP(tensp.text),
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
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
                        'Giá bán:            ',
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.w900),
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TextField(
                          controller: gia,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.5, color: Colors.black),
                            ),
                            contentPadding: const EdgeInsets.all(14),
                            border: const OutlineInputBorder(),
                            hintText: gia.text,
                            errorText: validateGia(gia.text),
                            labelStyle: const TextStyle(
                              color: Colors.black26,
                            ),
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
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
                            color: Colors.black87, fontWeight: FontWeight.w900),
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TextField(
                          controller: mota,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.5, color: Colors.black),
                            ),
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.all(60),
                            hintText: mota.text,
                            errorText: validateMT(mota.text),
                            labelStyle: const TextStyle(
                              color: Colors.black26,
                            ),
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
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
                            'Còn Hàng',
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          value: isCheck,
                          onChanged: (isCheck) async {
                            setState(() => this.isCheck = isCheck!);
                            {
                              if (isCheck == true) {
                                isSale = 1;
                              } else {
                                isSale = 0;
                              }
                            }
                            print('sssssdsadasdas $isSale');
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
                            color: Colors.black87, fontWeight: FontWeight.w900),
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 1, 5, 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: _image != null
                        ? Image.file(_image!, fit: BoxFit.cover)
                        : Image(
                            image: NetworkImage('${widget.ppro.image}'),
                            width: 50,
                          ),
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

                              print('asdasd ${widget.ppro.productImage}');
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
                            updateData(widget.ppro.productId);
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
    );
  }

  Future updateData(var id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString("login");
    var response;
    String myUrl = "http://192.168.88.241:8000/api/product/update";
    Dio dio = Dio();
    if (_image == null) {
      response = await dio.put(myUrl,
          options: Options(
            headers: {'Authorization': 'Bearer ${pref.getString("login")}'},
            followRedirects: false,
          ),
          data: {
            'product_id': id,
            'product_name': tensp.text,
            'product_price': gia.text,
            'is_sales': isSale,
            'description': mota.text,
          });
    } else {
      String fileName = _image!.path.split('/').last;
      var formData = FormData.fromMap({
        'product_id': id,
        "product_image": await MultipartFile.fromFile(
          _image!.path,
          filename: fileName,
        ),
        'product_name': tensp.text,
        'product_price': gia.text,
        'is_sales': isSale,
        'description': mota.text,
        '_method': 'PUT',
      });
      response = await dio.post(myUrl,
          options: Options(
            headers: {'Authorization': 'Bearer ${pref.getString("login")}'},
            followRedirects: false,
          ),
          data: formData);
    }

    if (response.data['status'] == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Lưu Thành Công ')));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const TaskHome()));
      return response.data;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lưu Không Thành Công ${response.data} ')));
      print(response.data);
    }
  }
}
