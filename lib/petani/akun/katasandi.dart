import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class katasandiPetani extends StatefulWidget {
  const katasandiPetani({Key key}) : super(key: key);

  @override
  State<katasandiPetani> createState() => _katasandiPetaniState();
}

class _katasandiPetaniState extends State<katasandiPetani> {
  bool isHiddenPassword1 = true;
  bool isHiddenPassword2 = true;
  bool isHiddenPassword3 = true;
  final _key = new GlobalKey<FormState>();
  var penjual_id, katasandi, konfirmasi;

  // fungsi buka tutup password
  void _togglePasswordView2() {
    if (isHiddenPassword2 == true) {
      isHiddenPassword2 = false;
    } else {
      isHiddenPassword2 = true;
    }
    setState(() {});
  }

  void _togglePasswordView3() {
    if (isHiddenPassword3 == true) {
      isHiddenPassword3 = false;
    } else {
      isHiddenPassword3 = true;
    }
    setState(() {});
  }

  //fungsi untuk menampilkan eror
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
      updatePassword();
    }
  }

  // fungsi untuk mengirim password dan mengupdate pada db
  updatePassword() async {
    SharedPreferences localdata = await SharedPreferences.getInstance();
    setState(() {
      penjual_id = localdata.getString('penjual_id');
    });
    Uri url = Uri.parse("http://192.168.27.135:8080/api/updatepenjual");
    final response = await http.post(url, body: {
      "penjual_id": penjual_id,
      'password': katasandi,
      'password_confirmation': konfirmasi,
    });
    final data = jsonDecode(response.body);
    int value = data['success'];
    var pesan = data['message'];
    if (value == 1) {
      print(pesan);
      setState(() {
        Navigator.pop(context);
      });
    } else {
      errorSnackBar(context, 'Lengkapi password dengan benar');
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
            'Katasandi',
            style: TextStyle(
                fontFamily: 'Mulish',
                fontSize: 23.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _key,
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'Jumlah kata sandi minimal 6 karakter dan disarankan kombinasi antara angka huruf dan karakter khusus',
                    style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                      validator: (e) {
                        if (e.isEmpty) {
                          return 'masukkan password baru';
                        }
                      },
                      onSaved: (e) => katasandi = e,
                      obscureText: isHiddenPassword2,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(Icons.visibility),
                            onPressed: _togglePasswordView2),
                        hintText: 'Katasandi Baru',
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF53B175)),
                        ),
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                      validator: (e) {
                        if (e.isEmpty) {
                          return 'konfirmasi password baru';
                        }
                      },
                      onSaved: (e) => konfirmasi = e,
                      obscureText: isHiddenPassword3,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(Icons.visibility),
                            onPressed: _togglePasswordView3),
                        hintText: 'Konfirmasi Katasandi Baru',
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF53B175)),
                        ),
                      )),
                  SizedBox(
                    height: MediaQueryHeight * 0.15,
                  ),
                  Center(
                    child: SizedBox(
                      height: 43,
                      width: 135,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF53B175))),
                          onPressed: () {
                            check();
                          },
                          child: Text(
                            'Konfirmasi',
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800),
                          )),
                    ),
                  )
                ],
              ),
            ),
          )),
        ));
  }
}
