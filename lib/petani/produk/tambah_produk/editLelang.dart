import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:rojotani/Awal/loginPelanggan.dart';
import 'package:rojotani/Awal/registerAs.dart';
import 'package:http/http.dart' as http;
import 'package:rojotani/petani/navPetani.dart';
import 'package:rojotani/petani/produk/katalog.dart';
import 'package:rojotani/petani/produk/product_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rojotani/Awal/loginPetani.dart';

class editLelang extends StatefulWidget {
  @override
  State<editLelang> createState() => _editLelangState();
}

class _editLelangState extends State<editLelang> {
  bool isHiddenPassword = true;
  String nama, satuan, jumlah, jenis, deskripsi, status;
  var namaL, hargaL, jumlahL, satuanL, jenisL, deskripsiL, statusL;
  var harga, stok, penjual_id, lelang_id, dataLelang;
  final _key = new GlobalKey<FormState>();

  errorSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color.fromARGB(255, 184, 15, 3),
      content: Text(text),
      duration: const Duration(seconds: 3),
    ));
  }

  getDataLelang() async {
    SharedPreferences localdata = await SharedPreferences.getInstance();
    setState(() {
      lelang_id = localdata.getString('lelang_id');
    });
    Uri url = Uri.parse("http://192.168.27.135:8080/api/lelang/edit");
    final response = await http.post(url, body: {
      "lelang_id": lelang_id,
    });
    dataLelang = jsonDecode(response.body);
    setState(() {
      namaL = dataLelang['nama'];
      hargaL = dataLelang['harga'].toString();
      jumlahL = dataLelang['jumlah'].toString();
      satuanL = dataLelang['satuan'];
      jenisL = dataLelang['jenis'];
      deskripsiL = dataLelang['deskripsi'];
      statusL = dataLelang['status'];
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      update();
    }
  }

  update() async {
    Uri url = Uri.parse("http://192.168.27.135:8080/api/lelang/update");
    final response = await http.post(url, body: {
      "lelang_id": lelang_id,
      'nama': nama,
      'harga': harga,
      'jumlah': jumlah,
      'satuan': satuan,
      'jenis': jenis,
      'deskripsi': deskripsi,
      'status': status,
    });
    final data = jsonDecode(response.body);
    int value = data['success'];
    var pesan = data['message'];
    if (value == 1) {
      print(pesan);
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navPetani()),
        );
      });
    } else {
      errorSnackBar(context, 'Produk telah tersedia');
    }
  }

  @override
  void initState() {
    super.initState();
    getDataLelang();
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
            'Edit Produk Lelang ',
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
                            color: Color.fromARGB(255, 221, 219, 219),
                            height: MediaQuery.of(context).size.height * 0.67,
                            //width: MediaQuery.of(context).size.width * 0.6,
                            child: Padding(
                              padding: EdgeInsets.only(left: 26.w),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text('Nama Produk',
                                        style: TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600)),
                                    TextFormField(
                                      controller:
                                          TextEditingController(text: namaL),
                                      validator: (e) {
                                        if (e.isEmpty) {
                                          return 'masukkan username';
                                        }
                                      },
                                      onSaved: (e) => nama = e,
                                      onChanged: (e) {
                                        setState(() {
                                          namaL = e;
                                        });
                                      },
                                      autofocus: false,
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
                                      height: 10.h,
                                    ),
                                    Text('harga Produk',
                                        style: TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600)),
                                    TextFormField(
                                      validator: (e) {
                                        if (e.isEmpty) {
                                          return 'masukkan harga';
                                        }
                                      },
                                      onSaved: (e) => harga = e,
                                      controller:
                                          TextEditingController(text: hargaL),
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: 'masukkan harga',
                                        hintStyle: TextStyle(
                                          // <-- Change this
                                          fontSize: 16.sp,
                                        ),
                                        // contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/4)
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text('satuan Produk',
                                        style: TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600)),
                                    TextFormField(
                                      validator: (e) {
                                        if (e.isEmpty) {
                                          return 'masukkan satuan';
                                        }
                                      },
                                      onSaved: (e) => satuan = e,
                                      controller:
                                          TextEditingController(text: satuanL),
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: 'masukkan satuan',
                                        hintStyle: TextStyle(
                                          // <-- Change this
                                          fontSize: 16.sp,
                                        ),
                                        // contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/4)
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text('jumlah Produk',
                                        style: TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600)),
                                    TextFormField(
                                      validator: (e) {
                                        if (e.isEmpty) {
                                          return 'masukkan jumlah';
                                        }
                                      },
                                      onSaved: (e) => jumlah = e,
                                      controller:
                                          TextEditingController(text: jumlahL),
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: 'masukkan jumlah',
                                        hintStyle: TextStyle(
                                          // <-- Change this
                                          fontSize: 16.sp,
                                        ),
                                        // contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/4)
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text('jenis Produk',
                                        style: TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600)),
                                    TextFormField(
                                      validator: (e) {
                                        if (e.isEmpty) {
                                          return 'masukkan jenis';
                                        }
                                      },
                                      onSaved: (e) => jenis = e,
                                      controller:
                                          TextEditingController(text: jenisL),
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: 'masukkan jenis',
                                        hintStyle: TextStyle(
                                          // <-- Change this
                                          fontSize: 16.sp,
                                        ),
                                        // contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/4)
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text('deskripsi Produk',
                                        style: TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600)),
                                    TextFormField(
                                      validator: (e) {
                                        if (e.isEmpty) {
                                          return 'masukkan deskripsi';
                                        }
                                      },
                                      onSaved: (e) => deskripsi = e,
                                      controller: TextEditingController(
                                          text: deskripsiL),
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: 'masukkan deskripsi',
                                        hintStyle: TextStyle(
                                          // <-- Change this
                                          fontSize: 16.sp,
                                        ),
                                        // contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/4)
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text('status Lelang',
                                        style: TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600)),
                                    TextFormField(
                                      validator: (e) {
                                        if (e.isEmpty) {
                                          return 'masukkan status';
                                        }
                                      },
                                      onSaved: (e) => status = e,
                                      controller:
                                          TextEditingController(text: statusL),
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText:
                                            'sedang di lelang / lelang selesai',
                                        hintStyle: TextStyle(
                                          // <-- Change this
                                          fontSize: 16.sp,
                                        ),
                                        // contentPadding: EdgeInsets.symmetric(vertical:
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 29.h,
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

                                    // print(penjual_id.toString());
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
