import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rojotani/petani/produk/detail/daftarTawar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class profilTawar extends StatefulWidget {
  const profilTawar({Key key}) : super(key: key);

  @override
  State<profilTawar> createState() => _profilTawarState();
}

class _profilTawarState extends State<profilTawar> {
  var lelang_id, pembeli_id, tawar_id, status_tawar = 'terima', pesan, _future;
  final _key = new GlobalKey<FormState>();

  errorSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color.fromARGB(255, 184, 15, 3),
      content: Text(text),
      duration: const Duration(seconds: 3),
    ));
  }

  Future getDataTawar() async {
    SharedPreferences localdata = await SharedPreferences.getInstance();
    setState(() {
      tawar_id = localdata.getString('tawar_id');
    });
    final String url =
        'http://192.168.27.135:8080/api/datatawarid'; //api menampilkan data tawar
    final response = await http.post(url, body: {
      "tawar_id": tawar_id,
      // "pembeli_id": pembeli_id,
    });
    return jsonDecode(response.body);
  }

  update() async {
    SharedPreferences dataTawar = await SharedPreferences.getInstance();
    setState(() {
      tawar_id = dataTawar.getString('tawar_id');
    });
    Uri url = Uri.parse("http://192.168.27.135:8080/api/status/update");
    final response = await http.post(url, body: {
      'tawar_id': tawar_id,
      'status_tawar': status_tawar,
    });
    final data = jsonDecode(response.body);
    var value = data['success'];
    pesan = data['message'];

    if (value == 1) {
      print(pesan);
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => daftarTawar()),
        );
      });
    } else {
      errorSnackBar(context, 'Data sudah di input');
    }
  }

  getWar() async {
    SharedPreferences tawarPro = await SharedPreferences.getInstance();
    setState(() {
      tawar_id = tawarPro.getString('tawar_id');
    });
  }

  // getPem() async {
  //   SharedPreferences localId = await SharedPreferences.getInstance();
  //   setState(() {
  //     pembeli_id = localId.getString('pembeli_id');
  //   });
  // }

  @override
  void initState() {
    super.initState();
    getWar();
    // getPem();
    _future = getDataTawar();
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
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Profil Penawar ',
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
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        height: MediaQueryHeight * 0.45,
                        width: MediaQueryWidth * 0.9,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 204, 204, 204),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                                width: 100,
                                height: 100,
                                decoration: ShapeDecoration(
                                  color: Colors.blue,
                                  shape: CircleBorder(),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(500.r),
                                    child: Image.network(
                                      'http://192.168.27.135:8080/public/gambar/userpembeli/' +
                                          snapshot.data['gambar'],
                                      fit: BoxFit
                                          .fill, // alamat untuk mengambil gambar
                                    )

                                    // alamat untuk mengambil gambar
                                    )),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              snapshot.data['nama_pembeli'],
                              style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 21.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            Divider(
                              thickness: 3,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 150.w),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Alamat :',
                                      style: TextStyle(
                                          fontFamily: 'Mulish',
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      snapshot.data['alamat'],
                                      style: TextStyle(
                                          fontFamily: 'Mulish',
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                      'Tawaran :',
                                      style: TextStyle(
                                          fontFamily: 'Mulish',
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      'Rp. ' +
                                          snapshot.data['harga_tawar']
                                              .toString(),
                                      style: TextStyle(
                                          fontFamily: 'Mulish',
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 230, 97, 9)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQueryHeight * 0.28,
                      ),
                      InkWell(
                        onTap: () {
                          update();
                        },
                        child: Container(
                          height: MediaQueryHeight * 0.073,
                          width: MediaQueryWidth * 0.38,
                          decoration: BoxDecoration(
                              color: Color(0xFF53B175),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Center(
                            child: Text(
                              'Terima',
                              style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 23.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
              } else {
                return Center(
                  child: Text('Load...'),
                );
              }
            }));
  }
}
