import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:rojotani/pelanggan/produk/product_card.dart';
import 'package:rojotani/pelanggan/produk/lelang_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  var pembeli_id, _future;

  // fungsi untuk menambil dan menampilkan data pembeli
  Future getDataPenjual() async {
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

  @override
  void initState() {
    // getPref();
    _future = getDataPenjual();
  }

  // fungsi untuk refresh
  Future<void> _refresh() {
    setState(() {
      productCard();
      lelangCard();
    });

    return Future.delayed(Duration(seconds: 2));
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

    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    Widget appbar() {
      return FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Row(
                children: [
                  SizedBox(
                    width: 40.w,
                  ),
                  Container(
                    width: MediaQueryWidth * 0.3,
                    margin: EdgeInsets.only(top: 70.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hai, ',
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF53B175)),
                        ),
                        Text(
                          snapshot.data['nama'],
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF53B175)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: MediaQueryWidth * 0.4),
                  Container(
                      margin: EdgeInsets.only(top: 40.h),
                      width: 40,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: Colors.blue,
                        shape: CircleBorder(),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(500.r),
                          child: Image.network(
                            'http://192.168.27.135:8080/public/gambar/userpembeli/' +
                                snapshot.data['gambar'],
                            fit: BoxFit.fill,
                          )

                          // alamat untuk mengambil gambar
                          )),
                ],
              );
            } else {
              return Center(
                child: Text('Load...'),
              );
            }
          });
    }

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0), // here the desired height
            child: appbar()),
        body: RefreshIndicator(
          color: Color(0xFF53B175),
          onRefresh: _refresh,
          child: SafeArea(
              child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 38.sp),
                child: Text(
                  'Lelang',
                  style: TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              lelangCard(), // mengambil halaman dari lelang card
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 38.sp),
                child: Text(
                  'Produk',
                  style: TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              productCard(), // mengambil halaman dari product card
              SizedBox(
                height: 10.h,
              ),
            ]),
          )),
        ));
  }
}
