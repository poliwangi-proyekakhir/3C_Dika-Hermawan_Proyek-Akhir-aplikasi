import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rojotani/Awal/loginPetani.dart';
import 'package:rojotani/petani/akun/katasandi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profilPetani extends StatefulWidget {
  // const profilPetani({Key key}) : super(key: key);

  @override
  // final VoidCallback signOut;
  // profilPetani(this.signOut);
  State<profilPetani> createState() => _profilPetaniState();
}

class _profilPetaniState extends State<profilPetani> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Route route = MaterialPageRoute(builder: (context) => loginPetaniPage());
    Navigator.push(context, route);
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
          title: Center(
            child: Text(
              'Akun',
              style: TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                _image == null
                    ? Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.22,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width * 0.42,
                                decoration: BoxDecoration(
                                  //color: Colors.grey,
                                  borderRadius: BorderRadius.circular(100.r),
                                  image: DecorationImage(
                                    image:
                                        AssetImage('asset/profil/kosong.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton(
                                  onPressed: getImage,
                                  backgroundColor: Color(0xFF53B175),
                                  child: Icon(Icons.camera_alt),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.22,
                          width: MediaQuery.of(context).size.width * 0.42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width * 0.42,
                                child: ClipOval(
                                  child: Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton(
                                  onPressed: getImage,
                                  backgroundColor: Color(0xFF53B175),
                                  child: Icon(Icons.camera_alt),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Text('Dika Hermawan'
                      //  snapshot.data[index]['nama'],
                      // style: TextStyle(
                      // fontFamily: 'Mulish',
                      // fontSize: 23.sp,
                      // fontWeight:
                      // FontWeight.w600),
                      ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.32,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 223, 220, 220),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.sp,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 223, 220, 220),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15.w,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.14,
                                decoration: BoxDecoration(
                                  color: Color(0xFF53B175),
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Icon(
                                  Icons.person_outline_rounded,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(
                                'Profil',
                                style: TextStyle(
                                    fontFamily: 'Mulish',
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 120.w,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 35.sp,
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 3,
                        ),
                        InkWell(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => katasandiPetani());
                            Navigator.push(context, route);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 223, 220, 220),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15.w,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  width:
                                      MediaQuery.of(context).size.width * 0.14,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF53B175),
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: Icon(
                                    Icons.password_rounded,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  'Password',
                                  style: TextStyle(
                                      fontFamily: 'Mulish',
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: 80.w,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 35.sp,
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 3,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 223, 220, 220),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: InkWell(
                            onTap: () {
                              signOut();
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15.w,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  width:
                                      MediaQuery.of(context).size.width * 0.14,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF53B175),
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: Icon(
                                    Icons.logout_outlined,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  'Keluar',
                                  style: TextStyle(
                                      fontFamily: 'Mulish',
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: 110.w,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 35.sp,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
