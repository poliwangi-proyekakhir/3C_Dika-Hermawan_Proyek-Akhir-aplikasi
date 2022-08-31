import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:rojotani/petani/produk/product_card.dart';
import 'package:rojotani/petani/produk/tambah_produk/tambahLelang.dart';
import 'package:rojotani/petani/produk/tambah_produk/tambahProduk.dart';
import 'package:rojotani/petani/produk/tambah_produk/tambahProduk.dart';

import '../../petani/produk/lelang_card.dart';

class katalogPage extends StatefulWidget {
  @override
  State<katalogPage> createState() => _katalogPageState();
}

class _katalogPageState extends State<katalogPage> {
  Future<void> _refresh() {
    return Future.delayed(Duration(seconds: 0));
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
    Widget appbar() {
      return (isLandscape)
          ? Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  height: MediaQuery.of(context).size.height * 0.10,
                  child: Image.asset('asset/gambar/logo.png'),
                ),
              ],
            )
          ///////////////////
          //Potrait
          : Container(
              margin: EdgeInsets.only(top: 80.h),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30.w),
                    child: Image.asset(
                      'asset/gambar/logo.png',
                    ),
                  ),
                  SizedBox(width: 150.w),
                ],
              ),
            );
    }

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0), // here the desired height
            child: appbar()),
        body: SafeArea(
            child: (isLandscape)
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: RefreshIndicator(
                      onRefresh: _refresh,
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 25,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 38.sp),
                                child: Text(
                                  'Lelang',
                                  style: TextStyle(
                                      fontFamily: 'Mulish',
                                      fontSize: 40.sp,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              lelangCard(),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20.w),
                                child: Text(
                                  'Produk',
                                  style: TextStyle(
                                      fontFamily: 'Mulish',
                                      fontSize: 45.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SingleChildScrollView(
                                child: Container(
                                  margin:
                                      EdgeInsets.only(left: 25.w, right: 15.w),
                                  width: 375.w,
                                  height:
                                      MediaQuery.of(context).size.height * 0.65,
                                  child: GridView.count(
                                    crossAxisCount: 3,
                                    childAspectRatio: 23 / 25,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 8,
                                    children: [
                                      // productCard(
                                      //   img: 'asset/gambar/pissang.png',
                                      //   title: 'Pisang Ambon',
                                      //   harga: 'Rp. 15.000 / Kg',
                                      //   press: () {},
                                      // ),
                                      // productCard(
                                      //   img: 'asset/gambar/lemuru.png',
                                      //   title: 'Ikan Lemuru',
                                      //   harga: 'Rp. 10.000 / Kg',
                                      //   press: () {},
                                      // ),
                                      // productCard(
                                      //   img: 'asset/gambar/nangka.png',
                                      //   title: 'Nangka',
                                      //   harga: 'Rp. 20.000 / Buah',
                                      //   press: () {},
                                      // ),
                                      // productCard(
                                      //   img: 'asset/gambar/jagung.png',
                                      //   title: 'Jagung Manis',
                                      //   harga: 'Rp. 3000 / Kg',
                                      //   press: () {},
                                      // ),
                                      // productCard(
                                      //   img: 'asset/gambar/kakap.png',
                                      //   title: 'Ikan Kakap',
                                      //   harga: 'Rp. 17.000 / Kg',
                                      //   press: () {},
                                      // ),
                                      // productCard(
                                      //   img: 'asset/gambar/tengiri.png',
                                      //   title: 'Ikan Tengiri',
                                      //   harga: 'Rp. 8000 / Kg',
                                      //   press: () {},
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  )
                ////////////////////////////
                //Potrait
                : RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 60.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 40.sp),
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
                              lelangCard(),
                              SizedBox(
                                height: 20.h,
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
                              productCard()
                              // Container(
                              //   color: Colors.grey[200],
                              //   height: MediaQuery.of(context).size.height * 0.29,
                              //   width: MediaQuery.of(context).size.width * 3,
                              //   child: Row(
                              //     children: [
                              //       SizedBox(
                              //         width: 20.w,
                              //       ),
                              //       InkWell(
                              //         onTap: () {
                              //           Route route = MaterialPageRoute(
                              //               builder: (context) => tambahProduk());
                              //           Navigator.push(context, route);
                              //         },
                              //         child: Container(
                              //           margin: EdgeInsets.only(right: 6.w),
                              //           width: MediaQuery.of(context).size.width *
                              //               0.25,
                              //           height: MediaQuery.of(context).size.height *
                              //               0.25,
                              //           decoration: BoxDecoration(
                              //             color: Colors.white,
                              //             borderRadius: BorderRadius.circular(15.r),
                              //             border: Border.all(
                              //                 width: 1.w, color: Colors.grey),
                              //           ),
                              //           child: Icon(
                              //             Icons.add,
                              //             size: 40,
                              //           ),
                              //         ),
                              //       ),
                              //       productCard()
                              //       // Container(
                              //       //   width:
                              //       //       MediaQuery.of(context).size.width * 0.68,
                              //       //   child: SingleChildScrollView(
                              //       //     scrollDirection: Axis.horizontal,
                              //       //     child: Row(
                              //       //       children: [
                              //       //         productCard(
                              //       //             // img: 'asset/gambar/jagung.png',
                              //       //             // title: 'Pisang Ambon',
                              //       //             // harga: 'Rp. 15.000 / Kg',
                              //       //             // press: () {},
                              //       //             ),
                              //       //         // productCard(
                              //       //         //   img: 'asset/gambar/jagung.png',
                              //       //         //   title: 'Pisang Ambon',
                              //       //         //   harga: 'Rp. 15.000 / Kg',
                              //       //         //   press: () {},
                              //       //         // ),
                              //       //         // productCard(
                              //       //         //   img: 'asset/gambar/jagung.png',
                              //       //         //   title: 'Pisang Ambon',
                              //       //         //   harga: 'Rp. 15.000 / Kg',
                              //       //         //   press: () {},
                              //       //         // ),
                              //       //       ],
                              //       //     ),
                              //       //   ),
                              //       // ),
                              //     ],
                              //   ),
                              // ),
                            ]),
                      ],
                    ),
                  )));
  }
}
