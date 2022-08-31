import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rojotani/pelanggan/produk/tawar/tawar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class lelangCard extends StatefulWidget {
  @override
  State<lelangCard> createState() => _lelangCardState();
}

class _lelangCardState extends State<lelangCard> {
  final String url = 'http://192.168.27.135:8080/api/getlelangall';

  // fungsi untuk meambil dan menampilkan data lelang secara keseluruhan
  Future getLelang() async {
    var response = await http.get(url); //api menampilkan data produk
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  // fugsi untuk mengambil id lelag dari penyimpanan lokal
  Future getDataLelang(lelang_id) async {
    SharedPreferences dataLelang = await SharedPreferences.getInstance();
    dataLelang..setString('lelang_id', lelang_id.toString());
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

    Size size = MediaQuery.of(context).size;
    return (isLandscape)
        ? Container(
            margin: EdgeInsets.only(right: 6.w),
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(width: 1.w, color: Colors.grey),
            ),
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15.h,
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Image.asset(
                          '',
                          width: size.width * 0.21,
                          height: size.width * 0.13,
                        )),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 5.0,
                        ),
                        width: 75.w,
                        child: Text(
                          '',
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 18.0,
                        ),
                        width: 138,
                        child: Text(
                          '',
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 53.w,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 18.0,
                        ),
                        width: 60,
                        child: Text(
                          '',
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Material(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            width: size.width * 0.195,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(
                              color: Color(0xFF53B175),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: Text(
                                "Tawar",
                                style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        :
        /////////////////////////////////////////////////
        //Potrait
        FutureBuilder(
            future: getLelang(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Color(0xFF53B175),
                  height: MediaQuery.of(context).size.height * 0.32,
                  width: MediaQuery.of(context).size.width * 1,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 6.w),
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.r),
                                border:
                                    Border.all(width: 1.w, color: Colors.grey),
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            child: Image.network(
                                              'http://192.168.27.135:8080/imglelang/lelang/' +
                                                  snapshot.data['data'][index][
                                                      'gambar'], // alamat untuk mengambil gambar
                                            )),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 17.w,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            right: 16.0,
                                          ),
                                          width: 138.w,
                                          child: Text(
                                            snapshot.data['data'][index]
                                                ['nama'],
                                            style: TextStyle(
                                                fontFamily: 'Mulish',
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 17.w,
                                        ),
                                        Container(
                                          width: 138,
                                          child: Text(
                                            'Rp. ' +
                                                snapshot.data['data'][index]
                                                        ['harga']
                                                    .toString() +
                                                ' / ' +
                                                snapshot.data['data'][index]
                                                    ['satuan'],
                                            style: TextStyle(
                                                fontFamily: 'Mulish',
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 28.w),
                                          child: Container(
                                            child: Text(
                                              snapshot.data['data'][index]
                                                  ['status'],
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 197, 21, 8),
                                                  fontFamily: 'Mulish',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Material(
                                            child: InkWell(
                                              onTap: () {
                                                getDataLelang(snapshot
                                                    .data['data'][index]['id']);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          tawar()),
                                                );
                                              },
                                              child: Container(
                                                width: size.width * 0.35,
                                                height: size.height * 0.04,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF53B175),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Tawar",
                                                    style: TextStyle(
                                                      fontFamily: 'Mulish',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                );
              } else {
                return Center(child: Text(' Data Eror'));
              }
            });
  }
}
