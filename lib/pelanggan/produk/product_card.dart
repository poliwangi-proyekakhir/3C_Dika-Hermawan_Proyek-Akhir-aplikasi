import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rojotani/pelanggan/produk/detail/detailProduk.dart';
import 'package:rojotani/pelanggan/transaksi/cekOut.dart';
import 'package:shared_preferences/shared_preferences.dart';

class productCard extends StatefulWidget {
  @override
  State<productCard> createState() => _productCardState();
}

class _productCardState extends State<productCard> {
  final String url = 'http://192.168.27.135:8080/api/getprodukall';

  // mengambil dan menampilkan data produk
  Future getProduk() async {
    var response = await http.get(url); //api menampilkan data produk
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  // mengambil id produk dari penyimpana lokal
  Future getDataProduk(produk_id) async {
    SharedPreferences dataProduk = await SharedPreferences.getInstance();
    dataProduk..setString('produk_id', produk_id.toString());
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
            margin: EdgeInsets.only(
              top: 10.h,
            ),
            width: MediaQuery.of(context).size.width * 0.38,
            height: MediaQuery.of(context).size.height * 0.28,
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
                      top: 10.h,
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40.r),
                        child: Image.asset(
                          '',
                          width: size.width * 0.23,
                          height: size.width * 0.18,
                        )),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 12.w,
                      ),
                      Container(
                        //color: Colors.blue,
                        margin: const EdgeInsets.only(
                          right: 16.0,
                        ),
                        width: 86.w,
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
                    height: 3.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 12.w,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 18.0,
                        ),
                        width: 161,
                        child: Text(
                          '',
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 23.sp,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 75.w,
                      ),
                      Material(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            width: size.width * 0.06,
                            height: size.height * 0.080,
                            decoration: BoxDecoration(
                              color: Color(0xFF53B175),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
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
        /////////////////////////////////////////////////
        //Potrait
        : FutureBuilder(
            future: getProduk(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                    child: Container(
                  margin: EdgeInsets.only(left: 25.w, right: 25.w),
                  width: 375.w,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 16 / 21,
                        crossAxisSpacing: 15,
                      ),
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            top: 10.h,
                          ),
                          width: MediaQuery.of(context).size.width * 0.38,
                          height: MediaQuery.of(context).size.height * 0.28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                                width: 1.w,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          child: InkWell(
                            onTap: () {
                              getDataProduk(snapshot.data['data'][index]['id']);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => detailProduk()),
                              );
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          'http://192.168.27.135:8080/img/produk/' +
                                              snapshot.data['data'][index][
                                                  'gambar'], // alamat untuk mengambil gambar
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 18.w,
                                    ),
                                    Container(
                                      width: 125,
                                      child: Text(
                                        snapshot.data['data'][index]['nama'],
                                        style: TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 16.sp,
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
                                      width: 18.w,
                                    ),
                                    Container(
                                      width: 125,
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
                                  height: 8.h,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100.w,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Material(
                                        child: InkWell(
                                          onTap: () {
                                            getDataProduk(snapshot.data['data']
                                                [index]['id']);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      cekoutPage()),
                                            );
                                          },
                                          child: Container(
                                            width: size.width * 0.12,
                                            height: size.height * 0.055,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF53B175),
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
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
                        );
                      }),
                ));
              } else {
                return Center(child: Text(' Data Eror'));
              }
            });
  }
}
