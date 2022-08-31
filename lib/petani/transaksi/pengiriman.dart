import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'pengiriman/diProses.dart' as diproses;
import 'pengiriman/selesai.dart' as selesai;

class pengirimanPage extends StatefulWidget {
  @override
  _pengirimanPageState createState() => _pengirimanPageState();
}

class _pengirimanPageState extends State<pengirimanPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget Title() {
    return Padding(
      padding: EdgeInsets.only(right: 60.0),
      child: Column(
        children: [
          Center(
            child: Text(
              'Transaksi',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Mulish',
                color: Colors.black,
                fontSize: 22.sp,
              ),
            ),
          ),
          Divider(
            thickness: 1,
          ),
        ],
      ),
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
      //create appBar
      appBar: new AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Title(),
        centerTitle: true,
        bottom: TabBar(
          controller: controller,
          labelColor: Color(0xFF53B175),
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xFF53B175),
          indicatorWeight: 3.w,
          tabs: <Widget>[
            Tab(
                child: Text('Di Proses',
                    style: TextStyle(
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp))),
            Tab(
                child: Text('Selesai',
                    style: TextStyle(
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp))),
          ],
        ),
      ),

      body: TabBarView(
        controller: controller,
        children: <Widget>[
          diproses.diProsesPage(),
          selesai.selesaiPage(controller),
        ],
      ),
    );
  }
}
