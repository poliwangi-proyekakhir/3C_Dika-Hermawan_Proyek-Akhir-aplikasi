import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:rojotani/Awal/loginPelanggan.dart';
import 'package:rojotani/Awal/registerAs.dart';
import 'package:http/http.dart' as http;

class registerPelangganPage extends StatefulWidget {
  @override
  State<registerPelangganPage> createState() => _registerPelangganPageState();
}

class _registerPelangganPageState extends State<registerPelangganPage> {
  bool isHiddenPassword = true;
  String nama, alamat, email, password;
  final _key = new GlobalKey<FormState>();

  // fugsi memunculkan snackbar
  errorSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color.fromARGB(255, 184, 15, 3),
      content: Text(text),
      duration: const Duration(seconds: 3),
    ));
  }

  // fungsi untuk validasi apakah data sudah terisi atau tidak
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  // fungsi untuk mengirim data ke backend untuk menambah data
  save() async {
    final response =
        await http.post("http://192.168.27.135:8080/api/regpembeli", body: {
      'nama': nama,
      'alamat': alamat,
      'email': email,
      'password': password,
    });
    final data = jsonDecode(response.body);
    int value = data['success'];
    var pesan = data['pesan'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
    } else {
      errorSnackBar(context, 'Email telah tersedia');
    }
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
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Route route =
                  MaterialPageRoute(builder: (context) => registerAsPage());
              Navigator.push(context, route);
            },
          ),
          title: Text(
            'Daftar',
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
          key: _key, // mendefinisikan agar apat merekam data berdasarkan key
          child: SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36.w),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60.h,
                          ),
                          Image.asset(
                            'asset/gambar/logo.png',
                          ),
                          SizedBox(
                            height: 26.h,
                          ),
                          Text(
                            'Cari produk berkualitas dengan harga terjangkau cuma di Rojotani !!',
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 47.h,
                          ),
                          Text(
                            'Daftar Akun',
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 19.h,
                          ),
                          TextFormField(
                            validator: (e) {
                              if (e.isEmpty) {
                                return 'masukkan username';
                              }
                            },
                            onSaved: (e) => nama = e, // untuk merekam value
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(10.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.r),
                                    borderSide: BorderSide(
                                        color: Color(0xFF53B175), width: 2.w)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14.w, vertical: 14.h),
                                hintText: 'Masukkan Ussername',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Mulish',
                                    fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(
                            height: 19.h,
                          ),
                          TextFormField(
                            validator: (e) {
                              if (e.isEmpty) {
                                return 'masukkan alamat';
                              }
                            },
                            onSaved: (e) => alamat = e, // untuk merekam value
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(10.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.r),
                                    borderSide: BorderSide(
                                        color: Color(0xFF53B175), width: 2.w)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14.w, vertical: 14.h),
                                hintText: 'Masukkan Alamat',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Mulish',
                                    fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(
                            height: 19.h,
                          ),
                          TextFormField(
                            validator: (e) {
                              if (e.isEmpty) {
                                return 'masukkan email';
                              }
                            },
                            onSaved: (e) => email = e, // untuk merekam value
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(10.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.r),
                                    borderSide: BorderSide(
                                        color: Color(0xFF53B175), width: 2.w)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14.w, vertical: 14.h),
                                hintText: 'Masukkan E-mail',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Mulish',
                                    fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(
                            height: 19.h,
                          ),
                          TextFormField(
                            validator: (e) {
                              if (e.isEmpty) {
                                return 'masukkan password';
                              }
                            },
                            onSaved: (e) => password = e, // untuk merekam value
                            obscureText:
                                isHiddenPassword, // menyembunyikan password
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed:
                                      _togglePasswordView, // berubah ketika di klik
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(10.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.r),
                                    borderSide: BorderSide(
                                        color: Color(0xFF53B175), width: 2.w)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14.w, vertical: 14.h),
                                hintText: 'Masukkan Katasandi',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Mulish',
                                    fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(
                            height: 64.h,
                          ),
                          new Container(
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
                                  check(); // menjalankan fungsi cek ketika di klik
                                },
                                child: Center(
                                  child: Text(
                                    'Daftar',
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
                          SizedBox(
                            height: 30.h,
                          ),
                          new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ' Telah Memiliki Akun? ',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.black,
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.w600),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Route route = MaterialPageRoute(
                                        builder: (context) =>
                                            loginPelangganPage());
                                    Navigator.push(context, route);
                                  },
                                  child: Text(
                                    'Masuk',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Color(0xFF53B175),
                                        fontFamily: 'Mulish',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ]),
                        ]),
                  ))),
        ));
  }

  // fungsi menampilkan dan menyembuyikan password
  void _togglePasswordView() {
    if (isHiddenPassword == true) {
      isHiddenPassword = false;
    } else {
      isHiddenPassword = true;
    }
    setState(() {});
  }
}
