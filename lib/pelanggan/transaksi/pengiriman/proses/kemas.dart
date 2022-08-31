import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class kemasPage extends StatefulWidget {
  @override
  State<kemasPage> createState() => _kemasPageState();
}

class _kemasPageState extends State<kemasPage> {
  var cekout_id,
      pembeli_id,
      data,
      _future,
      textbtn = 'bayar',
      btnCol = Color(0xFF53B175),
      fontCol = Colors.white;
  final _key = new GlobalKey<FormState>();

  errorSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color.fromARGB(255, 184, 15, 3),
      content: Text(text),
      duration: const Duration(seconds: 3),
    ));
  }

  File _imageFile;

  // fungsi utuk memaggil data dari tabel cekout dan pembeli
  Future getCekout() async {
    SharedPreferences localId = await SharedPreferences.getInstance();
    setState(() {
      pembeli_id = localId.getString('pembeli_id');
    });
    final String url = 'http://192.168.27.135:8080/api/status/kemas';
    final response = await http.post(url, body: {
      "pembeli_id": pembeli_id, // mengirim  id sesuai data yag diminta
    });
    return jsonDecode(response.body);
  }

  // fungsi mengambil gambar dari galeri
  _pilihGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _imageFile = image;
    });
  }

  //fungsi utuk mevalidasi value yang diiputkan
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    }
  }

  //fungsi untuk meambahka data berupa gambar dan beberapa data dari pembeli id
  submit() async {
    try {
      var stream =
          http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
      var length = await _imageFile.length();
      var uri = Uri.parse("http://192.168.27.135:8080/api/bayar");
      var request = http.MultipartRequest("POST", uri);
      request.fields['cekout_id'] = cekout_id;
      request.fields['pembeli_id'] = pembeli_id;

      request.files.add(http.MultipartFile("gambar", stream, length,
          filename: path.basename(_imageFile.path)));
      var response = await request.send();
      if (response.statusCode > 2) {
        print("image upload");
        setState(() {
          textbtn = 'Menunggu Validasi';
          btnCol = Color(0xFFFFFFF);
          fontCol = Colors.black;
        });
      } else {
        print("image failed");
      }
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _future = getCekout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Form(
                key: _key,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(top: 17.sp),
                  decoration: BoxDecoration(
                      //color: Colors.blue,
                      border: Border.all(color: Colors.grey[300], width: 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            10,
                          ),
                          topRight: Radius.circular(10))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Container(
                                        width: 95,
                                        height: 95,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            child: Image.network(
                                              'http://192.168.27.135:8080/img/produk/' +
                                                  snapshot.data[index]
                                                      ['gambar'],
                                              fit: BoxFit
                                                  .fill, // alamat untuk mengambil gambar
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        snapshot.data[index]['nama_produk'],
                                        style: TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 20.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        'Jumlah : ' +
                                            snapshot.data[index]['jumlah']
                                                .toString(),
                                        style: TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 18.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        'Total : Rp. ' +
                                            snapshot.data[index]['total_bayar']
                                                .toString(),
                                        style: TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 18.sp,
                                            color: Color(0xFF53B175),
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Text(
                                'alamat : ' + snapshot.data[index]['alamat'],
                                style: TextStyle(
                                    fontFamily: 'Mulish',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'catatan: ' + snapshot.data[index]['catatan'],
                                style: TextStyle(
                                    fontFamily: 'Mulish',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              SizedBox(height: 54.h),
                              Divider(
                                thickness: 5,
                                color: Colors.black,
                              )
                            ],
                          );
                        }),
                  ),
                ),
              );
            } else {
              return Center(child: Text('Load......'));
            }
          }),
    );
  }
}
