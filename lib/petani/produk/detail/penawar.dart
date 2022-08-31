import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rojotani/pelanggan/produk/detail/detailProduk.dart';
import 'package:rojotani/petani/produk/detail/profilTawar/profilTawar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class penawar extends StatefulWidget {
  const penawar({Key key}) : super(key: key);

  @override
  State<penawar> createState() => _penawarState();
}

class _penawarState extends State<penawar> {
  var lelang_id, tawar_id, status_tawar = 'terima', pesan, _future;
  final _key = new GlobalKey<FormState>();

  errorSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color.fromARGB(255, 184, 15, 3),
      content: Text(text),
      duration: const Duration(seconds: 3),
    ));
  }

  Future getDatawar() async {
    SharedPreferences localdata = await SharedPreferences.getInstance();
    setState(() {
      lelang_id = localdata.getString('lelang_id');
    });
    final String url =
        'http://192.168.27.135:8080/api/ambildatatawar'; //api menampilkan data produk
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

  Future getTawarData(tawar_id) async {
    SharedPreferences tawardata = await SharedPreferences.getInstance();
    tawardata..setString('tawar_id', tawar_id.toString());
  }

  Future getPembeliData(pembeli_id) async {
    SharedPreferences pembelidata = await SharedPreferences.getInstance();
    pembelidata..setString('pembeli_id', pembeli_id.toString());
  }

  @override
  void initState() {
    super.initState();
    getLelang();
    _future = getDatawar();
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
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQueryWidth * 0.53,
                              top: MediaQueryHeight * 0.008),
                          child: Text(
                            'Daftar Tawaran ',
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                color: Colors.black,
                                fontSize: 21.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          width: MediaQueryWidth * 0.93,
                          height: MediaQueryHeight * 0.245,
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      getTawarData(snapshot.data[index]['id']);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                profilTawar()),
                                      );
                                    },
                                    child: Container(
                                      width: MediaQueryWidth * 0.93,
                                      height: MediaQueryHeight * 0.08,
                                      child: Card(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 5.sp,
                                            ),
                                            Icon(Icons.person),
                                            SizedBox(
                                              width: 5.sp,
                                            ),
                                            Container(
                                              width: MediaQueryWidth * 0.4,
                                              child: Text(
                                                snapshot.data[index]
                                                    ['nama_pembeli'],
                                                style: TextStyle(
                                                    fontFamily: 'Mulish',
                                                    color: Colors.black,
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40.sp,
                                            ),
                                            Container(
                                              width: MediaQueryWidth * 0.22,
                                              child: Text(
                                                'Rp. ' +
                                                    snapshot.data[index]
                                                            ['harga_tawar']
                                                        .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Mulish',
                                                    color: Color(0xFF53B175),
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.sp,
                                            ),
                                            Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Icon(Icons
                                                      .arrow_forward_ios_rounded)
                                                ]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
          } else {
            return Center(child: Text('Load....'));
          }
        });
  }
}
