import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rojotani/pelanggan/produk/navPembeli.dart';
import 'package:shared_preferences/shared_preferences.dart';

class tawar extends StatefulWidget {
  const tawar({Key key}) : super(key: key);

  @override
  State<tawar> createState() => _tawarState();
}

class _tawarState extends State<tawar> {
  var lelang_id, pembeli_id, harga_tawar, pesan, _future;
  final _key = new GlobalKey<FormState>();

  // fungsi untuk menampilkan snackbar
  errorSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color.fromARGB(255, 184, 15, 3),
      content: Text(text),
      duration: const Duration(seconds: 3),
    ));
  }

  // fungsi untuk mengambil data dan ditampilkan
  Future getDataLelang() async {
    SharedPreferences localdata = await SharedPreferences.getInstance();
    setState(() {
      lelang_id = localdata.getString('lelang_id');
    });
    final String url =
        'http://192.168.27.135:8080/api/tawar/ambildata'; //api menampilkan data produk
    final response = await http.post(url, body: {
      "lelang_id": lelang_id,
      "pembeli_id": pembeli_id,
    });
    return jsonDecode(response.body);
  }

  // fungsi untuk mengambil id pembeli dari penyimpaan lokal
  getPembeli() async {
    SharedPreferences localId = await SharedPreferences.getInstance();
    setState(() {
      pembeli_id = localId.getString('pembeli_id');
    });
  }

  // fungsi untuk mengambil id lelang dari penyimpaan lokal
  getLelang() async {
    SharedPreferences dataLelang = await SharedPreferences.getInstance();
    setState(() {
      lelang_id = dataLelang.getString('lelang_id');
    });
  }

  // fungsi untuk validasi value yang diinputkan
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      tawar();
    }
  }

  // fungsi untuk meegirim data tawar ke backend yang kemudian di tambahkan
  tawar() async {
    Uri url = Uri.parse("http://192.168.27.135:8080/api/tawar");
    final response = await http.post(url, body: {
      'lelang_id': lelang_id,
      'pembeli_id': pembeli_id,
      'harga_tawar': harga_tawar,
    });
    final data = jsonDecode(response.body);
    var value = data['success'];
    pesan = data['message'];

    // menyimpan dan menyediakan data id tawar secara local untuk digunakan berikutnya
    SharedPreferences tawardata = await SharedPreferences.getInstance();
    tawardata..setString('tawar_id', data['tawar_id']);

    if (value == 1) {
      print(pesan);
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navPembeli()),
        );
      });
    } else {
      errorSnackBar(context, 'Data sudah di input');
    }
  }

  @override
  void initState() {
    super.initState();

    getPembeli();
    getLelang();
    _future = getDataLelang();
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
            'Detail Produk',
            style: TextStyle(
                fontFamily: 'Mulish',
                fontSize: 23.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Form(
                  key: _key,
                  child: SafeArea(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                    color: Colors.blue,
                                    height: MediaQuery.of(context).size.height *
                                        0.45,
                                    child: Image.network(
                                      'http://192.168.27.135:8080/imglelang/lelang/' +
                                          snapshot.data['lelang']['gambar'],
                                      fit: BoxFit
                                          .fill, // alamat untuk mengambil gambar
                                    )),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      snapshot.data['lelang']['nama'],
                                      style: TextStyle(
                                        fontFamily: 'Mulish',
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      'Minimal Rp. ' +
                                          snapshot.data['lelang']['harga']
                                              .toString() +
                                          '  |  ' +
                                          'jumlah ' +
                                          snapshot.data['lelang']['jumlah']
                                              .toString() +
                                          ' ' +
                                          snapshot.data['lelang']['satuan'],
                                      style: TextStyle(
                                        color: Color(0xFF53B175),
                                        fontFamily: 'Mulish',
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      snapshot.data['lelang']['status'],
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 182, 20, 8),
                                        fontFamily: 'Mulish',
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      'Deskripsi Produk',
                                      style: TextStyle(
                                        fontFamily: 'Mulish',
                                        fontSize: 21.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      snapshot.data['lelang']['deskripsi'],
                                      style: TextStyle(
                                        fontFamily: 'Mulish',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: MediaQueryWidth * 0.58,
                                    top: MediaQueryHeight * 0.007),
                                child: Text(
                                  'Tawar Produk',
                                  style: TextStyle(
                                      fontFamily: 'Mulish',
                                      color: Colors.black,
                                      fontSize: 21.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              SizedBox(
                                height: 17.h,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 18.w,
                                  ),
                                  Container(
                                    width: MediaQueryWidth * 0.5,
                                    height: MediaQueryHeight * 0.07,
                                    child: TextFormField(
                                      validator: (e) {
                                        if (e.isEmpty) {
                                          return 'masukkan Tawaran';
                                        }
                                      },
                                      onSaved: (e) => harga_tawar = e,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10.r),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      10.r),
                                              borderSide: BorderSide(
                                                  color: Color(0xFF53B175),
                                                  width: 2.w)),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 14.w, vertical: 20.h),
                                          hintText: 'Masukkan Tawaran',
                                          hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Mulish',
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      check();
                                    },
                                    child: Container(
                                      width: MediaQueryWidth * 0.35,
                                      height: MediaQueryHeight * 0.07,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        color: Color(0xFF53B175),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Tawar ',
                                          style: TextStyle(
                                            fontFamily: 'Mulish',
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                );
              } else {
                return Center(child: Text('Load'));
              }
            }));
  }
}
