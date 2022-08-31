import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
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
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: EdgeInsets.only(left: 32.w, right: 32.w),
          child: Container(
            height: 50.h,
            // color: Colors.blue,
            child: Row(
              children: [
                Container(
                  width: 247.w,
                  height: 39.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.r),
                            borderSide: BorderSide(color: Colors.grey)),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 12.h),
                        hintText: 'Cari Disini',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.shopping_cart_outlined,
                    )),
                SizedBox(
                  width: 5.w,
                ),
                Container(
                    // color: Colors.blue,
                    height: 29.h,
                    width: 28.w,
                    child: Stack(
                      children: [
                        InkWell(
                            onTap: () {},
                            child: Icon(Icons.notifications_outlined)),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(right: 5.w, top: 5.h),
                            height: 11.h,
                            width: 11.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red[700]),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 26.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 32.w),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 160.h,
              aspectRatio: 30 / 15,
              viewportFraction: 0.8,
            ),
            items: ["asset/slider/banner1.png", "asset/slider/banner2.png"]
                .map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: 6.w),
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        i,
                      ));
                },
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: 13.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 32.w),
          child: Text(
            'Kategori',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'Mulish'),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 32.w, right: 32.w),
          child: Container(
            child: Row(
              children: [
                Column(
                  children: [
                    Image.asset(
                      "asset/kategori/pertanian.png",
                      height: 90.h,
                    ),
                    SizedBox(
                      height: 3.sp,
                    ),
                    Text('Pertanian',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Mulish')),
                  ],
                ),
                SizedBox(
                  width: 22.w,
                ),
                Column(
                  children: [
                    Image.asset(
                      "asset/kategori/peternakan.png",
                      height: 90.h,
                    ),
                    SizedBox(
                      height: 3.sp,
                    ),
                    Text('Peternakan',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Mulish')),
                  ],
                ),
                SizedBox(
                  width: 22.w,
                ),
                Column(
                  children: [
                    Image.asset(
                      "asset/kategori/perikanan.png",
                      height: 90.h,
                    ),
                    SizedBox(
                      height: 3.sp,
                    ),
                    Text('Perikanan',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Mulish')),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.w,
        ),
        Padding(
            padding: EdgeInsets.only(left: 32.w),
            child: Text(
              'Sedang Lelang',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Mulish'),
            )),
        Padding(
          padding: EdgeInsets.only(left: 32.w),
          child: Card(
            child: Column(
              children: [
                Image.asset('asset/gambar/pisang.png'),
                Text('data'),
              ],
            ),
          ),
        )
      ]),
    )));
  }
}
