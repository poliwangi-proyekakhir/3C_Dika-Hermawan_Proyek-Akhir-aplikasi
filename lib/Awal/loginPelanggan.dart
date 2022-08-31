import 'dart:convert';
import 'package:rojotani/pelanggan/produk/home.dart';
import 'package:rojotani/pelanggan/produk/navPembeli.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:rojotani/Awal/registerPelanggan.dart';
import 'package:rojotani/Awal/loginAs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginPelangganPage extends StatefulWidget {
  @override
  State<loginPelangganPage> createState() => _loginPelangganPageState();
}

enum LoginStatus { notSignIn, SignIn } //inisialisasi status login

class _loginPelangganPageState extends State<loginPelangganPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email, password;
  bool isHiddenPassword = true;
  final _key = new GlobalKey<FormState>();

  // fugsi untuk menampilkan snackbar
  errorSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color.fromARGB(255, 184, 15, 3),
      content: Text(text),
      duration: const Duration(seconds: 3),
    ));
  }

// fungsi untu validasi data dan mengarahkan ke fungsi login
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

// fugsi untuk proses login
  Future<Map<String, dynamic>> login() async {
    final response = await http.post(
        "http://192.168.27.135:8080/api/logpembeli",
        body: {'email': email, 'password': password});
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    var value = data['success'];
    String pesan = data['message'];

    //menyimpan dan menyediakan data id pembeli yang login secara local

    SharedPreferences localId = await SharedPreferences.getInstance();
    localId.setString('pembeli_id', data['pembeli_id']);

    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.SignIn;
        savePref(value);
      });
      print(pesan);
    } else {
      errorSnackBar(context, 'Akun tidak Valid');
    }
  }

  // menyimpan value status login atau tidak, ketika reload tetap pada status terakhr signout atau logout
  savePref(int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt('value', value);
      preferences.commit();
    });
  }

// mengambil value dari set pref / penyimpanan local
  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt('value');
      _loginStatus = value == 1 ? LoginStatus.SignIn : LoginStatus.notSignIn;
    });
  }

  //fungsi mejalankan fungsi yag aka digunakan atau dijalankan
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
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
                      MaterialPageRoute(builder: (context) => loginAsPage());
                  Navigator.push(context, route);
                },
              ),
              title: Text(
                'Masuk',
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
                                'Masukkan Akun Pembeli',
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
                                onSaved: (e) => email = e,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.r),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.r),
                                        borderSide: BorderSide(
                                            color: Color(0xFF53B175),
                                            width: 2.w)),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 14.w, vertical: 14.h),
                                    hintText: 'Username',
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Mulish',
                                        fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(
                                height: 19.h,
                              ),
                              TextFormField(
                                onSaved: (e) => password = e,
                                obscureText: isHiddenPassword,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.visibility),
                                        onPressed: _togglePasswordView),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.r),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.r),
                                        borderSide: BorderSide(
                                            color: Color(0xFF53B175),
                                            width: 2.w)),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 14.w, vertical: 14.h),
                                    hintText: 'Katasandi',
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Mulish',
                                        fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(
                                height: 35.h,
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
                                      check();
                                    },
                                    child: Center(
                                      child: Text(
                                        'Masuk',
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
                                      ' Belum Memiliki Akun? ',
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.black,
                                          fontFamily: 'Mulish',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (cotext) =>
                                                    registerPelangganPage()));
                                      },
                                      child: Text(
                                        'Daftar',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Color(0xFF53B175),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ]),
                            ]),
                      ))),
            ));
        break;
      case LoginStatus.SignIn:
        return navPembeli();
    }
  }

  // fungsi buka tutup pasword
  void _togglePasswordView() {
    if (isHiddenPassword) {
      isHiddenPassword = false;
    } else {
      isHiddenPassword = true;
    }
    setState(() {});
  }
}
