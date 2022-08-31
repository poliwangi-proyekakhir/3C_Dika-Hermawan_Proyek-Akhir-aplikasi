import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:rojotani/petani/produk/tambah_produk/editProduk.dart';
import 'package:rojotani/petani/produk/tambah_produk/tambahProduk.dart';
// import 'package:rojotani/petani/produk/tambah_produk/tambahProduk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class productCard extends StatefulWidget {
  const productCard({Key key}) : super(key: key);

  @override
  State<productCard> createState() => _productCardState();
}

class _productCardState extends State<productCard> {
  var penjual_id;
  var _future;

  //function menampilkan data produk
  Future getProducts() async {
    SharedPreferences localdata = await SharedPreferences.getInstance();
    setState(() {
      penjual_id = localdata.getString('penjual_id');
    });
    final String url =
        'http://192.168.27.135:8080/api/getproduk'; //api menampilkan data produk
    final response = await http.post(url, body: {
      "penjual_id": penjual_id,
    });
    return jsonDecode(response.body);
  }

  Future getDataBarang(produk_id) async {
    SharedPreferences localdata = await SharedPreferences.getInstance();
    localdata..setString('produk_id', produk_id.toString());
  }

  //function delete

  Future deleteProduct(id) async {
    String url = 'http://192.168.27.135:8080/api/deleteProduk/' +
        id; //api menghapus data produk
    var response = await http.delete(Uri.parse(url));
    setState(() {
      _future = getProducts();
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
                        deleteProduct(id);
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

  // Future deleteProduct(String produk_id) async {
  //   String url = 'http://192.168.27.135:8080/api/delete/' +
  //       produk_id; //api menghapus data produk
  //   var response = await http.delete(Uri.parse(url));
  //   print(json.decode(response.body));
  //   return json.decode(response.body);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getProducts();
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
                    // child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(40.r),
                    //     child: Image.asset(
                    //       img,
                    //       width: size.width * 0.23,
                    //       height: size.width * 0.18,
                    //     )),
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
                        // child: Text(
                        //   title,
                        //   style: TextStyle(
                        //       fontFamily: 'Mulish',
                        //       fontSize: 28.sp,
                        //       fontWeight: FontWeight.w800),
                        // ),
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
                        // child: Text(
                        //   harga,
                        //   style: TextStyle(
                        //       fontFamily: 'Mulish',
                        //       fontSize: 23.sp,
                        //       fontWeight: FontWeight.w800),
                        // ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          )
        /////////////////////////////////////////////////
        //Potrait
        : FutureBuilder(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Colors.grey[200],
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 3,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      InkWell(
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => tambahProduk());
                          Navigator.push(context, route);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 6.w),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(width: 1.w, color: Colors.grey),
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
                                  margin: EdgeInsets.only(
                                    left: 10.w,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.38,
                                  height:
                                      MediaQuery.of(context).size.height * 0.28,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.r),
                                    border: Border.all(
                                        width: 1.w, color: Colors.grey),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      // getDataBarang(snapshot.data[index]['id']);
                                      // Route route = MaterialPageRoute(
                                      //     builder: (context) => editProduk());
                                      // Navigator.push(context, route);
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
                                                  'http://192.168.27.135:8080/img/produk/' +
                                                      snapshot.data[index][
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
                                              width: 12.w,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                right: 12.0,
                                              ),
                                              width: 110,
                                              child: Text(
                                                snapshot.data[index]['nama'],
                                                style: TextStyle(
                                                    fontFamily: 'Mulish',
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 12),
                                            child: Text(
                                              'Rp ' +
                                                  snapshot.data[index]['harga']
                                                      .toString() +
                                                  ' / ' +
                                                  snapshot.data[index]
                                                      ['satuan'],
                                              style: TextStyle(
                                                  fontFamily: 'Mulish',
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  getDataBarang(snapshot
                                                      .data[index]['id']);
                                                  Route route =
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              editProduk());
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
                                                  //     .then((value) {
                                                  //   ScaffoldMessenger.of(context)
                                                  //       .showSnackBar(SnackBar(
                                                  //     content: Text(
                                                  //         'produk berhasil di hapus'),
                                                  //   ));
                                                  // });
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
                                )
                              ],
                            );
                          },
                          // arah kekiri
                          scrollDirection: Axis.horizontal,
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Center(child: Text(' Data Eror'));
              }
            });
  }
}
