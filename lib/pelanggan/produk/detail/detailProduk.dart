import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rojotani/pelanggan/produk/navPembeli.dart';
import 'package:rojotani/pelanggan/transaksi/cekOut.dart';
import 'package:shared_preferences/shared_preferences.dart';

class detailProduk extends StatefulWidget {
  const detailProduk({Key key}) : super(key: key);

  @override
  State<detailProduk> createState() => _detailProdukState();
}

class _detailProdukState extends State<detailProduk> {
  var produk_id, pembeli_id, _future;

  // fungsi untuk menampilkan snackbar
  errorSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color.fromARGB(255, 184, 15, 3),
      content: Text(text),
      duration: const Duration(seconds: 3),
    ));
  }

  // fungsi untuk mengambil data dan ditampilkan
  Future getDataProduk() async {
    SharedPreferences localdata = await SharedPreferences.getInstance();
    setState(() {
      produk_id = localdata.getString('produk_id');
    });
    final String url =
        'http://192.168.27.135:8080/api/detaildata'; //api menampilkan data produk
    final response = await http.post(url, body: {
      "produk_id": produk_id,
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
  getProduk() async {
    SharedPreferences dataLelang = await SharedPreferences.getInstance();
    setState(() {
      produk_id = dataLelang.getString('produk_id');
    });
  }

  Future getProdukData(produk_id) async {
    SharedPreferences dataProduk = await SharedPreferences.getInstance();
    dataProduk..setString('produk_id', produk_id.toString());
  }

  @override
  void initState() {
    super.initState();

    getPembeli();
    getProduk();
    _future = getDataProduk();
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
                return SafeArea(
                    child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.787,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              color: Colors.blue,
                              height: MediaQuery.of(context).size.height * 0.45,
                              child: Image.network(
                                'http://192.168.27.135:8080/img/produk/' +
                                    snapshot.data['gambar'],
                                fit: BoxFit.cover,
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
                                  snapshot.data['nama'],
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
                                  'Rp. ' + snapshot.data['harga'].toString(),
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
                                  'Sisa ' +
                                      snapshot.data['stok'].toString() +
                                      ' ' +
                                      snapshot.data['satuan'],
                                  style: TextStyle(
                                    color: Colors.grey,
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
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  snapshot.data['deskripsi'],
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
                    InkWell(
                      onTap: () {
                        getProdukData(snapshot.data['id']);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => cekoutPage()),
                        );
                      },
                      child: Container(
                        color: Color(0xFF53B175),
                        height: MediaQuery.of(context).size.height * 0.081,
                        width: MediaQuery.of(context).size.width * 1,
                        child: Center(
                          child: Text(
                            'Beli Produk',
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                color: Colors.white,
                                fontSize: 23.sp,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    )
                  ],
                ));
              } else {
                return Center(
                  child: Text('Load...'),
                );
              }
            }));
  }
}
