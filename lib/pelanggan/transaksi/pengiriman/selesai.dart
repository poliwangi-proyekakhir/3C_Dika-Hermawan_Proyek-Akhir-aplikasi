import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class selesaiPage extends StatefulWidget {
  TabController controller;

  selesaiPage(this.controller);

  @override
  State<selesaiPage> createState() => _selesaiPageState();
}

class _selesaiPageState extends State<selesaiPage> {
  var pembeli_id, data, _future;

  final _key = new GlobalKey<FormState>();

  errorSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color.fromARGB(255, 184, 15, 3),
      content: Text(text),
      duration: const Duration(seconds: 3),
    ));
  }

// fungsi utuk memaggil data
  Future getCekout() async {
    SharedPreferences localId = await SharedPreferences.getInstance();
    setState(() {
      pembeli_id = localId.getString('pembeli_id');
    });
    final String url =
        'http://192.168.27.135:8080/api/status/selesai'; //api menampilkan data  dari cekout id
    final response = await http.post(url, body: {
      "pembeli_id": pembeli_id, // mengirim  id sesuai data yag diminta
    });
    return jsonDecode(response.body);
  }

  @override
  void initState() {
    super.initState();
    _future = getCekout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Form(
                key: _key,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(top: 17),
                  decoration: BoxDecoration(
                      //color: Colors.blue,
                      border: Border.all(color: Colors.grey[300], width: 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            10,
                          ),
                          topRight: Radius.circular(10))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        width: 95,
                                        height: 95,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.network(
                                              'http://192.168.27.135:8080/img/produk/' +
                                                  snapshot.data[index]
                                                      ['gambar'],
                                              fit: BoxFit
                                                  .fill, // alamat untuk mengambil gambar
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        snapshot.data[index]['nama_produk'],
                                        style: TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Jumlah : ' +
                                            snapshot.data[index]['jumlah']
                                                .toString(),
                                        style: TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Total : Rp. ' +
                                            snapshot.data[index]['total_bayar']
                                                .toString(),
                                        style: TextStyle(
                                            fontFamily: 'Mulish',
                                            fontSize: 18,
                                            color: Color(0xFF53B175),
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Text(
                                'alamat : ' + snapshot.data[index]['alamat'],
                                style: TextStyle(
                                    fontFamily: 'Mulish',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'catatan: ' + snapshot.data[index]['catatan'],
                                style: TextStyle(
                                    fontFamily: 'Mulish',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 28,
                              ),
                              Divider(
                                thickness: 5,
                                color: Colors.black,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              );
            } else {
              return Center(child: Text('Load......'));
            }
          }),
    );
  }
}
