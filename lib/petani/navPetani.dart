import 'package:flutter/material.dart';
import 'package:rojotani/petani/produk/katalog.dart';
import 'package:rojotani/petani/transaksi/pengiriman.dart';

import 'akun/akunPetani.dart';

class navPetani extends StatefulWidget {
  @override
  _navPetaniState createState() => _navPetaniState();
}

class _navPetaniState extends State<navPetani> {
  int currentIndex = 0;
  final List<Widget> body = [katalogPage(), pengirimanPage(), akunPetani()];

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
