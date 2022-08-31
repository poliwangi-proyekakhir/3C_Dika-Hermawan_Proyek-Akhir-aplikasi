import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rojotani/pelanggan/produk/detail/detailProduk.dart';
import 'package:rojotani/petani/navPetani.dart';
import 'package:rojotani/petani/produk/detail/penawar.dart';
import 'package:rojotani/petani/produk/detail/profilTawar/profilTawar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class daftarTawar extends StatefulWidget {
  const daftarTawar({Key key}) : super(key: key);

  @override
  State<daftarTawar> createState() => _daftarTawarState();
}

class _daftarTawarState extends State<daftarTawar> {
  var lelang_id, tawar_id, status_tawar = 'terima', pesan, _future;
  final _key = new GlobalKey<FormState>();

  errorSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color.fromARGB(255, 184, 15, 3),
      content: Text(text),
      duration: const Duration(seconds: 3),
    ));
  }

  Future getDataProlang() async {
    SharedPreferences localdata = await SharedPreferences.getInstance();
    setState(() {
      lelang_id = localdata.getString('lelang_id');
    });
    final String url =
        'http://192.168.27.135:8080/api/lelang/ambildata'; //api menampilkan data produk
    final response = await http.post(url, body: {
      "lelang_id": lelang_id,
      // "penjual_id": penjual_id,
    });
    return jsonDecode(response.body);
  }

  getLelang() async {
    SharedPreferences dataLelang = await SharedPreferences.getInstance();
    setState(() {
      lelang_id = dataLelang.getString('lelang_id');
    });
  }

  // getPenjual() async {
  //   SharedPreferences localdata = await SharedPreferences.getInstance();
  //   setState(() {
  //     penjual_id = localdata.getString('penjual_id');
  //   });
  // }

  Future getTawar(tawar_id) async {
    SharedPreferences tawar = await SharedPreferences.getInstance();
    tawar..setString('tawar_id', tawar_id.toString());
  }

  // update() async {
  //   SharedPreferences dataTawar = await SharedPreferences.getInstance();
  //   setState(() {
  //     tawar_id = dataTawar.getString('tawar_id');
  //   });
  //   Uri url = Uri.parse("http://192.168.27.135:8080/api/status/update");
  //   final response = await http.post(url, body: {
  //     'tawar_id': tawar_id,
  //     'status_tawar': status_tawar,
  //   });
  //   final data = jsonDecode(response.body);
  //   var value = data['success'];
  //   pesan = data['message'];

  //   if (value == 1) {
  //     print(pesan);
  //     setState(() {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => detailProduk()),
  //       );
  //     });
  //   } else {
  //     errorSnackBar(context, 'Data sudah di input');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // getPenjual();
    getLelang();

    _future = getDataProlang();
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => navPetani()),
              );
            },
          ),
          title: Text(
            'Detail Produk ',
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
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.45,
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
                                    'Minimum Harga Rp. ' +
                                        snapshot.data['lelang']['harga'],
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
                      penawar()
                      // Container(
                      //   width: MediaQuery.of(context).size.width * 1,
                      //   child: Column(
                      //     children: [
                      //       Padding(
                      //         padding: EdgeInsets.only(
                      //             right: MediaQueryWidth * 0.53,
                      //             top: MediaQueryHeight * 0.008),
                      //         child: Text(
                      //           'Daftar Tawaran ',
                      //           style: TextStyle(
                      //               fontFamily: 'Mulish',
                      //               color: Colors.black,
                      //               fontSize: 21.sp,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: MediaQueryWidth * 0.93,
                      //         height: MediaQueryHeight * 0.245,
                      //         child: ListView.builder(
                      //           itemCount: snapshot.data.length,
                      //           itemBuilder: (context, index) {
                      //             return Column(
                      //               children: [
                      //                 InkWell(
                      //                   onTap: () {
                      //                     getTawar(snapshot.data[index]['id']);
                      //                     Navigator.push(
                      //                       context,
                      //                       MaterialPageRoute(
                      //                           builder: (context) =>
                      //                               profilTawar()),
                      //                     );
                      //                   },
                      //                   child: Container(
                      //                     width: MediaQueryWidth * 0.93,
                      //                     height: MediaQueryHeight * 0.08,
                      //                     child: Card(
                      //                       child: Row(
                      //                         children: [
                      //                           SizedBox(
                      //                             width: 5.sp,
                      //                           ),
                      //                           Icon(Icons.person),
                      //                           SizedBox(
                      //                             width: 5.sp,
                      //                           ),
                      //                           Container(
                      //                             width: MediaQueryWidth * 0.4,
                      //                             child: Text(
                      //                               snapshot.data["tawar"]
                      //                                   [index]['nama_pembeli'],
                      //                               style: TextStyle(
                      //                                   fontFamily: 'Mulish',
                      //                                   color: Colors.black,
                      //                                   fontSize: 16.sp,
                      //                                   fontWeight:
                      //                                       FontWeight.w600),
                      //                             ),
                      //                           ),
                      //                           SizedBox(
                      //                             width: 40.sp,
                      //                           ),
                      //                           Container(
                      //                             width: MediaQueryWidth * 0.22,
                      //                             child: Text(
                      //                               'Rp. ' +
                      //                                   snapshot.data["tawar"]
                      //                                           [index]
                      //                                           ['harga_tawar']
                      //                                       .toString(),
                      //                               style: TextStyle(
                      //                                   fontFamily: 'Mulish',
                      //                                   color:
                      //                                       Color(0xFF53B175),
                      //                                   fontSize: 16.sp,
                      //                                   fontWeight:
                      //                                       FontWeight.w700),
                      //                             ),
                      //                           ),
                      //                           SizedBox(
                      //                             width: 5.sp,
                      //                           ),
                      //                           Row(
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment.end,
                      //                               children: [
                      //                                 Icon(Icons
                      //                                     .arrow_forward_ios_rounded)
                      //                               ]),
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             );
                      //           },
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ));
              } else {
                return Center(child: Text('Load....'));
              }
            }));
  }
}
