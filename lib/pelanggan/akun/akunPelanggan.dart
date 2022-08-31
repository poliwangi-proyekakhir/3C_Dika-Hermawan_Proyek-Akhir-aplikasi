import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rojotani/Awal/loginPelanggan.dart';
import 'package:rojotani/Awal/loginPetani.dart';
import 'package:rojotani/pelanggan/akun/edit/editProfilPel.dart';
import 'package:rojotani/pelanggan/akun/katasandi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class akunPelanggan extends StatefulWidget {
  // const akunPelanggan({Key key}) : super(key: key);

  @override
  // final VoidCallback signOut;
  // akunPelanggan(this.signOut);
  State<akunPelanggan> createState() => _akunPelangganState();
}

class _akunPelangganState extends State<akunPelanggan> {
  var pembeli_id, _future;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future getDataPembeli() async {
    SharedPreferences localdata = await SharedPreferences.getInstance();
    setState(() {
      pembeli_id = localdata.getString('pembeli_id');
    });
    final String url =
        'http://192.168.27.135:8080/api/datapembeli'; //api menampilkan data produk
    final response = await http.post(url, body: {
      "pembeli_id": pembeli_id,
    });
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Route route = MaterialPageRoute(builder: (context) => loginPelangganPage());
    Navigator.push(context, route);
  }

  void initState() {
    // getPref();
    _future = getDataPembeli();
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
    );
    final MediaQueryHeight = MediaQuery.of(context).size.height;
    final MediaQueryWidth = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: Text(
            'Akun',
            style: TextStyle(
                fontFamily: 'Mulish',
                fontSize: 23.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ),
        body: FutureBuilder(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SafeArea(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 23.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40.h),
                        Center(
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.22,
                              width: MediaQuery.of(context).size.width * 0.46,
                              decoration: ShapeDecoration(
                                color: Colors.blue,
                                shape: CircleBorder(),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(500.r),
                                  child: Image.network(
                                    'http://192.168.27.135:8080/public/gambar/userpembeli/' +
                                        snapshot.data['gambar'],
                                    // 'asset/profil/kosong.png',
                                    fit: BoxFit
                                        .fill, // alamat untuk mengambil gambar
                                  )

                                  // alamat untuk mengambil gambar
                                  )),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: Text(
                            snapshot.data['nama'],
                            style: TextStyle(
                                fontSize: 23.sp,
                                fontFamily: 'Mulish',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 60.h,
                        ),
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.32,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 223, 220, 220),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10.sp,
                                ),
                                InkWell(
                                  onTap: () {
                                    Route route = MaterialPageRoute(
                                        builder: (context) => editProfilPel());
                                    Navigator.push(context, route);
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 223, 220, 220),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.14,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF53B175),
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child: Icon(
                                            Icons.person_outline_rounded,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Text(
                                          'Profil',
                                          style: TextStyle(
                                              fontFamily: 'Mulish',
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          width: 120.w,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 35.sp,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 3,
                                ),
                                InkWell(
                                  onTap: () {
                                    Route route = MaterialPageRoute(
                                        builder: (context) =>
                                            katasandiPelanggan());
                                    Navigator.push(context, route);
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 223, 220, 220),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.14,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF53B175),
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child: Icon(
                                            Icons.password_rounded,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Text(
                                          'Password',
                                          style: TextStyle(
                                              fontFamily: 'Mulish',
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          width: 80.w,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 35.sp,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 3,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 223, 220, 220),
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      signOut();
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.14,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF53B175),
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child: Icon(
                                            Icons.logout_outlined,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Text(
                                          'Keluar',
                                          style: TextStyle(
                                              fontFamily: 'Mulish',
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          width: 110.w,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 35.sp,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ));
              } else {
                return Center(child: Text('Load....'));
              }
            }));
  }
}
