import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:rojotani/Awal/loginPelanggan.dart';
import 'package:rojotani/Awal/registerAs.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:async/src/delegate/stream.dart';

import 'package:rojotani/petani/navPetani.dart';
import 'package:rojotani/petani/produk/katalog.dart';
import 'package:rojotani/petani/produk/product_card.dart';
import 'package:rojotani/petani/produk/tambah_produk/editLelang.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rojotani/Awal/loginPetani.dart';

class editProfilPetani extends StatefulWidget {
  @override
  State<editProfilPetani> createState() => _editProfilPetaniState();
}

class _editProfilPetaniState extends State<editProfilPetani> {
  var penjual_id, dataProduk;
  final _key = new GlobalKey<FormState>();

  File _imageFile;

  // fungsi menagmbil gambar dari galeri
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = image;
    });
  }

  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController rekeningController = TextEditingController();

  errorSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color.fromARGB(255, 184, 15, 3),
      content: Text(text),
      duration: const Duration(seconds: 3),
    ));
  }

  // mengambil id pejual dari penyimpanan lokal
  getPref() async {
    SharedPreferences localdata = await SharedPreferences.getInstance();
    setState(() {
      penjual_id = localdata.getString('penjual_id');
    });
  }

  // fungsi validasi value
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      update();
    }
  }

  // fungsi tambah data text dan gambar
  update() async {
    try {
      var stream =
          http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
      var length = await _imageFile.length();
      var uri = Uri.parse("http://192.168.27.135:8080/api/profilPenjual");
      var request = http.MultipartRequest("POST", uri);
      request.fields['penjual_id'] = penjual_id;
      request.fields['nama'] = namaController.text;
      request.fields['alamat'] = alamatController.text;

      request.files.add(http.MultipartFile("gambar", stream, length,
          filename: path.basename(_imageFile.path)));
      var response = await request.send();
      if (response.statusCode > 2) {
        print("image upload");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navPetani()),
        );
      } else {
        errorSnackBar(context, 'Data telah tersedia');
      }
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  @override
  void initState() {
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(390, 844),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Edit Profil',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Mulish',
              color: Colors.black,
              fontSize: 23,
            ),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _key,
          child: SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.67,
                            //width: MediaQuery.of(context).size.width * 0.6,
                            child: Padding(
                              padding: EdgeInsets.only(left: 26.w),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _imageFile == null
                                        ? Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.22,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45,
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.22,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.42,
                                                    decoration: BoxDecoration(
                                                      //color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.r),
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'asset/profil/kosong.png'),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: FloatingActionButton(
                                                      onPressed: getImage,
                                                      backgroundColor:
                                                          Color(0xFF53B175),
                                                      child: Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Center(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.22,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.42,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.r),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.22,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.42,
                                                    child: ClipOval(
                                                      child: Image.file(
                                                        _imageFile,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: FloatingActionButton(
                                                      onPressed: getImage,
                                                      backgroundColor:
                                                          Color(0xFF53B175),
                                                      child: Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                    SizedBox(
                                      height: 50.h,
                                    ),
                                    Text('Nama',
                                        style: TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600)),
                                    TextFormField(
                                      validator: (namaController) {
                                        if (namaController.isEmpty) {
                                          return 'masukkan nama';
                                        }
                                      },
                                      controller: namaController,
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: 'masukkan username',
                                        hintStyle: TextStyle(
                                          // <-- Change this
                                          fontSize: 16.sp,
                                        ),
                                        // contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/4)
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text('Alamat',
                                        style: TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600)),
                                    TextFormField(
                                      validator: (alamatController) {
                                        if (alamatController.isEmpty) {
                                          return 'masukkan alamat';
                                        }
                                      },
                                      controller: alamatController,
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: 'masukkan alamat',
                                        hintStyle: TextStyle(
                                          // <-- Change this
                                          fontSize: 16.sp,
                                        ),
                                        // contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/4)
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    SizedBox(
                                      height: 32.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 317.w,
                              height: 51.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Color(0xFF53B175),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    check();
                                  },
                                  child: Center(
                                    child: Text(
                                      'Simpan',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                          fontFamily: 'Mulish',
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                        ]),
                  ))),
        ));
  }
}
