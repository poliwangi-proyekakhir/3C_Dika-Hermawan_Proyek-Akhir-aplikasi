import 'package:flutter/material.dart';
import 'package:rojotani/pelanggan/produk/home.dart';
import 'package:rojotani/pelanggan/transaksi/pengiriman.dart';
import '../akun/akunPelanggan.dart';

class navPembeli extends StatefulWidget {
  @override
  _navPembeliState createState() => _navPembeliState();
}

class _navPembeliState extends State<navPembeli> {
  int currentIndex = 0; //  index halaman awal yang ditampilkan
  final List<Widget> body = [
    homePage(),
    pengirimanPage(),
    akunPelanggan()
  ]; // list halaman yang dituju

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: 'Home',
              activeIcon: Icon(
                Icons.home,
                color: Color(0xFF53B175),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.article_rounded,
                color: Colors.black,
              ),
              label: 'Transaksi',
              activeIcon: Icon(
                Icons.article_rounded,
                color: Color(0xFF53B175),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: 'Akun',
              activeIcon: Icon(
                Icons.person,
                color: Color(0xFF53B175),
              )),
        ],
      ),
    );
  }
}
