import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'proses/kemas.dart' as diKemas;
import 'proses/kirim.dart' as diKirim;
import 'proses/terima.dart' as diTerima;

class diProsesPage extends StatefulWidget {
  @override
  _diProsesPageState createState() => _diProsesPageState();
}

class _diProsesPageState extends State<diProsesPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Padding(
          padding: EdgeInsets.only(top: 46.h),
          child: TabBar(
            controller: controller,
            labelColor: Color(0xFF53B175),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF53B175),
            indicatorWeight: 0.001,
            tabs: <Widget>[
              Tab(
                  icon: new Icon(Icons.table_chart_rounded),
                  child: Text('Di Kemas',
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp))),
              Tab(
                  icon: new Icon(Icons.local_shipping),
                  child: Text('Di Kirim',
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp))),
              Tab(
                  icon: new Icon(Icons.check_circle),
                  child: Text('Di Terima',
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp))),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          diKemas.kemasPetani(controller),
          diKirim.kirimPetani(),
          diTerima.terimaPetani(),
        ],
      ),
    );
  }
}
