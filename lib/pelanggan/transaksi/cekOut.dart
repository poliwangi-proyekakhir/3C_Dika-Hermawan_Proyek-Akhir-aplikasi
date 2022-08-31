import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:rojotani/pelanggan/produk/navPembeli.dart';
import 'package:rojotani/pelanggan/transaksi/pengiriman/diProses.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cekoutPage extends StatefulWidget {
  @override
  _cekoutPageState createState() => _cekoutPageState();
}

class _cekoutPageState extends State<cekoutPage> {
  String nama, satuan, jenis, deskripsi;
  var namaP, hargaP, gambarP, satuanP, stokP, deskripsiP, jenisP, alamatPem;
  var pesan,
      jumlah,
      pembeli_id,
      produk_id,
      produkData,
      dataPembeli,
      status_pesanan,
      catatan,
      _future;
  final _key = new GlobalKey<FormState>();

  errorSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color.fromARGB(255, 184, 15, 3),
      content: Text(text),
      duration: const Duration(seconds: 3),
    ));
  }

  // fugsi mengambil dan menampilkan data dari tabel produk dan pembeli
  Future getProducts() async {
    SharedPreferences localdata = await SharedPreferences.getInstance();
    setState(() {
      produk_id = localdata.getString('produk_id');
    });
    final String url =
        'http://192.168.27.135:8080/api/cekout/ambilproduk'; //api menampilkan data produk
    final response = await http.post(url, body: {
      "produk_id": produk_id,
      "pembeli_id": pembeli_id,
    });
    return jsonDecode(response.body);
  }

  //fungsi mengambil id pembeli pada penyimpanan lokal
  getPembeli() async {
    SharedPreferences localId = await SharedPreferences.getInstance();
    setState(() {
      pembeli_id = localId.getString('pembeli_id');
    });
  }

  //fungsi mengambil id pembeli pada penyimpanan lokal
  getProduk() async {
    SharedPreferences dataProduk = await SharedPreferences.getInstance();
    setState(() {
      produk_id = dataProduk.getString('produk_id');
    });
  }

  // fungsi validasi value yang di input
  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      cekout();
    }
  }

  Future getDataCekout(cekout_id) async {
    SharedPreferences dataCekout = await SharedPreferences.getInstance();
    dataCekout..setString('cekout_id', cekout_id.toString());
  }

  // fungsi mengirim ke backend dan ditambahkan pada db
  cekout() async {
    Uri url = Uri.parse("http://192.168.27.135:8080/api/cekout");
    final response = await http.post(url, body: {
      'produk_id': produk_id,
      'pembeli_id': pembeli_id,
      'jumlah': jumlah,
      'catatan': catatan,
      // 'status_pesanan': status_pesanan,
    });
    final data = jsonDecode(response.body);
    var value = data['success'];
    pesan = data['message'];

    // menyimpan dan menyediakan data id cekout secara local untuk digunakan berikutnya
    SharedPreferences cekoutdata = await SharedPreferences.getInstance();
    cekoutdata.setString('cekout_id', data['cekout_id']);

    if (value == 1) {
      print(pesan);
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navPembeli()),
        );
      });
    } else {
      errorSnackBar(context, 'Lengkapi Data Pesanan');
    }
  }

  @override
  void initState() {
    super.initState();
    // getProdukData();
    getPembeli();
    getProduk();
    _future = getProducts();
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
          'Pesanan ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Mulish',
            color: Colors.black,
            fontSize: 22.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _future,
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Form(
                key: _key,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 34.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: ShapeDecoration(
                                    color: Colors.blue,
                                    shape: CircleBorder(),
                                  ),
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(500.r),
                                      child: Image.network(
                                        'http://192.168.27.135:8080/img/produk/' +
                                            snapshot.data['produk']['gambar'],
                                        fit: BoxFit
                                            .fill, // alamat untuk mengambil gambar
                                      )),
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
                                  snapshot.data['produk']['nama'],
                                  style: TextStyle(
                                      fontFamily: 'Mulish',
                                      fontSize: 20.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  'Rp. ' +
                                      snapshot.data['produk']['harga']
                                          .toString() +
                                      ' / ' +
                                      snapshot.data['produk']['satuan'],
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
                        Container(
                          width: 326.w,
                          height: 52.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 148, 146, 146),
                                width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              snapshot.data['pembeli']['alamat'],
                              style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 15.sp,
                                  color: Color.fromARGB(255, 99, 98, 98),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
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
                        Container(
                          height: 49.h,
                          child: TextFormField(
                            validator: (e) {
                              if (e.isEmpty) {
                                return 'masukkan catatan';
                              }
                            },
                            onSaved: (e) => catatan = e,
                            maxLines: 2,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(5.r),
                                  borderSide: BorderSide(
                                      color: Color(0xFF53B175), width: 2.w)),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 14.w, vertical: 14.h),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        Text('Jumlah Produk',
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 7.h,
                        ),
                        Container(
                          height: 49.h,
                          child: TextFormField(
                            validator: (e) {
                              if (e.isEmpty) {
                                return 'masukkan username';
                              }
                            },
                            onSaved: (e) => jumlah = e,
                            maxLines: 2,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(5.r),
                                  borderSide: BorderSide(
                                      color: Color(0xFF53B175), width: 2.w)),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 14.w, vertical: 14.h),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 40.w),
                          child: InkWell(
                            onTap: (() {
                              check();
                            }),
                            child: Container(
                              height: 45.h,
                              width: 251.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey[300], width: 1),
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
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: text('data eror'));
            }
          }),
    );
  }
}
