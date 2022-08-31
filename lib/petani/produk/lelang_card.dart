import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rojotani/petani/produk/detail/daftarTawar.dart';
import 'package:rojotani/petani/produk/tambah_produk/editLelang.dart';
import 'package:rojotani/petani/produk/tambah_produk/tambahLelang.dart';
import 'package:shared_preferences/shared_preferences.dart';

class lelangCard extends StatefulWidget {
  @override
  State<lelangCard> createState() => _lelangCardState();
}

class _lelangCardState extends State<lelangCard> {
  var penjual_id;
  var _future;

  //function menampilkan data lelang
  Future getLelangs() async {
    SharedPreferences localdata = await SharedPreferences.getInstance();
    setState(() {
      penjual_id = localdata.getString('penjual_id');
    });
    final String url =
        'http://192.168.27.135:8080/api/getlelang'; //api menampilkan data produk

    final response = await http.post(url, body: {
      "penjual_id": penjual_id,
    });
    return jsonDecode(response.body);
  }

  Future getLelangData(lelang_id) async {
    SharedPreferences localdata = await SharedPreferences.getInstance();
    localdata..setString('lelang_id', lelang_id.toString());
  }

  //function delete
  Future deleteLelang(id) async {
    String url = 'http://192.168.27.135:8080/api/deleteLelang/' +
        id; //api menghapus data produk
    var response = await http.delete(Uri.parse(url));
    setState(() {
      _future = getLelangs();
    });
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  dialogDelete(id) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              shrinkWrap: true,
              children: [
                Text(
                  'Apakah anda yakin akan menghapus?',
                  style: TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Tidak',
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF53B175),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    InkWell(
                      onTap: () {
                        deleteLelang(id);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Yakin',
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 138, 16, 7),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getLelangs();
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
                    // child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(20.r),
                    //     child: Image.asset(
                    //       widget.img,
                    //       width: size.width * 0.21,
                    //       height: size.width * 0.13,
                    //     )),
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
                          ' ',
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
                ],
              ),
            ),
          )
        :
        /////////////////////////////////////////////////
        //Potrait

        FutureBuilder(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Color(0xFF53B175),
                  height: MediaQuery.of(context).size.height * 0.32,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      InkWell(
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => tambahLelangPage());
                          Navigator.push(context, route);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 6.w),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 40,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.68,
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 6.w),
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.r),
                                    border: Border.all(
                                        width: 1.w, color: Colors.grey),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      getLelangData(snapshot.data[index]['id']);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                daftarTawar()),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                              5,
                                            ),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Image.network(
                                                  'http://192.168.27.135:8080/imglelang/lelang/' +
                                                      snapshot.data[index][
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
                                                snapshot.data[index]['nama'],
                                                style: TextStyle(
                                                    fontFamily: 'Mulish',
                                                    fontSize: 17.sp,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 16),
                                            child: Text(
                                              'Rp. ' +
                                                  snapshot.data[index]['harga']
                                                      .toString() +
                                                  ' / ' +
                                                  snapshot.data[index]
                                                      ['satuan'],
                                              style: TextStyle(
                                                  fontFamily: 'Mulish',
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 18.w,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                right: 18.0,
                                              ),
                                              width: 125,
                                              child: Text(
                                                snapshot.data[index]['status'],
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 197, 21, 8),
                                                    fontFamily: 'Mulish',
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  getLelangData(snapshot
                                                      .data[index]['id']);
                                                  Route route =
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              editLelang());
                                                  Navigator.push(
                                                      context, route);
                                                },
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: Color.fromARGB(
                                                      255, 14, 117, 201),
                                                  size: 25.w,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  dialogDelete(snapshot
                                                      .data[index]['id']
                                                      .toString());
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Color.fromARGB(
                                                      255, 197, 27, 15),
                                                  size: 25.w,
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: Text(' Data Eror'));
              }
            });
  }
}
