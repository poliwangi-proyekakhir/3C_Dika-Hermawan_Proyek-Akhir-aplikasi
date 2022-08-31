import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class cekoutPage extends StatefulWidget {
  @override
  _cekoutPageState createState() => _cekoutPageState();
}

class _cekoutPageState extends State<cekoutPage> {
  Widget getTextForm(Height, MaxLines) {
    return Container(
      height: Height,
      child: TextFormField(
        maxLines: MaxLines,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(5.r),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(5.r),
              borderSide: BorderSide(color: Color(0xFF53B175), width: 2.w)),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        ),
      ),
    );
  }

  Widget text(text) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Text(text,
          style: TextStyle(
              fontFamily: 'Mulish',
              fontSize: 15.sp,
              fontWeight: FontWeight.w600)),
    );
  }

  Widget space() {
    return Column(
      children: [
        SizedBox(
          height: 13.h,
        ),
        Divider(
          thickness: 1,
        ),
        SizedBox(
          height: 13.h,
        )
      ],
    );
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
    return new Scaffold(
        appBar: new AppBar(
          elevation: 3,
          backgroundColor: Colors.white,
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
            'Pemesanan',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Mulish',
              color: Colors.black,
              fontSize: 22.sp,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 34.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            // image: DecorationImage(
                            // image: AssetImage('asset/gambar/ayam.png'),
                            // fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daging Ayam',
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 18.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          '2 Kilogram',
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 15.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Rp 21.000',
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 18.sp,
                              color: Color(0xFF53B175),
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 22.h,
                ),
                Text('Alamat',
                    style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 7.h,
                ),
                getTextForm(79.h, 3),
                SizedBox(
                  height: 22.h,
                ),
                Text('Catatan',
                    style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 8.h,
                ),
                getTextForm(50.h, 1),
                SizedBox(
                  height: 22.h,
                ),
                Text('Metode Pembayaran',
                    style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 7.h,
                ),
                Container(
                    width: 326.w,
                    height: 52.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300], width: 1),
                      borderRadius: BorderRadius.circular(5),
                    )),
                SizedBox(
                  height: 22.h,
                ),
                Text('Pembayaran',
                    style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    text('Subtotal'),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      alignment: Alignment.bottomRight,
                      child: Text('Rp 42.000',
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
                space(),
                Row(
                  children: [
                    text('Ongkos Kirim'),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      alignment: Alignment.bottomRight,
                      child: Text('Rp 10.000',
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                space(),
                Row(
                  children: [
                    text('Total Pembayaran'),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.42,
                      alignment: Alignment.bottomRight,
                      child: Text('Rp 52.000',
                          style: TextStyle(
                              color: Colors.orangeAccent,
                              fontFamily: 'Mulish',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40.w),
                  child: Container(
                    height: 45.h,
                    width: 251.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300], width: 1),
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFF53B175)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cekout',
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
