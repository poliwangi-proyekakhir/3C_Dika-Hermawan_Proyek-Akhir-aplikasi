import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:rojotani/Awal/loginAs.dart';
import 'package:rojotani/Awal/registerPetani.dart';
import 'package:rojotani/Awal/registerPelanggan.dart';

class registerAsPage extends StatefulWidget {
  @override
  State<registerAsPage> createState() => _registerAsPageState();
}

class _registerAsPageState extends State<registerAsPage> {
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
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 36.w),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                'Daftar Sebagai',
                style: TextStyle(
                    fontFamily: 'Mulish',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 19.h,
              ),
              new Container(
                width: 317.w,
                height: 51.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF53B175),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => registerPetaniPage());
                      Navigator.push(context, route);
                    },
                    child: Center(
                      child: Text(
                        'PENJUAL PRODUK',
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
                height: 19.h,
              ),
              new Container(
                width: 317.w,
                height: 51.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF53B175),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => registerPelangganPage());
                      Navigator.push(context, route);
                    },
                    child: Center(
                      child: Text(
                        'PEMBELI PRODUK',
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
                height: 47.h,
              ),
              new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                    Route route =
                        MaterialPageRoute(builder: (context) => loginAsPage());
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
          ),
        )));
  }
}
