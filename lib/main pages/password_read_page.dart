import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled1/Models/Location.dart';

import '../Enrollment pages/enroll_page.dart';
import '../mysql.dart';
import '../student_main_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordReadPage extends StatefulWidget {
  @override
  _PasswordReadPageState createState() => _PasswordReadPageState();
}
final _sayiKontrolcu = TextEditingController();

String pass="";
String latmax="";
String latmin="";
String longmax="";
String longmin="";
bool _switchValue = false;

Future<void> getmySQLData() async {

  var db = Mysql();

  String sql =  "select * from attendancedata where MethodId='1' and Date_Add(AttendanceDate,interval 10 minute)>Date_Add(UTC_TIMESTAMP(),interval 3 hour)";

  await db.getConnection().then((conn) async {

    await conn.query(sql).then((results) {

      for (var res in results) {
        //print(res);
        pass=res['MethodKey'].toString();
        if(res['GPS'].toString()=="0") {
          _switchValue=false;
        } else {
          _switchValue=true;
        }
        // mylist.add(res['user_Id'].toString());

        // mylist.add(res['username'].toString());

        // mylist.add(res['email'].toString());


      }
      print(pass);
    }
    ).onError((error, stackTrace) {

      print(error);

      return null;

    });

    conn.close();

  });



}
Future<void> getLocation() async {

  var db = Mysql();

  String sql =  "select * from locationdata";

  await db.getConnection().then((conn) async {

    await conn.query(sql).then((results) {

      for (var res in results) {
        //print(res);
        latmax=res['LatitudeMax'].toString();
        latmin=res['LatitudeMin'].toString();
        longmax=res['LongitudeMax'].toString();
        longmin=res['LongitudeMin'].toString();
        print(longmax);
        print(longmin);
        print(latmax);
        print(latmin);
        // mylist.add(res['user_Id'].toString());

        // mylist.add(res['username'].toString());

        // mylist.add(res['email'].toString());


      }
      print(pass);
    }
    ).onError((error, stackTrace) {

      print(error);
      print("Err");

      return null;

    });

    conn.close();

  });



}
int studentid=0;
int lectureid=0;
Location location= Location(Latitude: "0", Longitude: "0");

Future<void> Getgps() async{
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Location permissions are denied');
    }else if(permission == LocationPermission.deniedForever){
      print("'Location permissions are permanently denied");
    }else{
      print("GPS Location service is granted");
    }
  }else{
    print("GPS Location permission granted.");
  }
  String long="";
  LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high, //accuracy of the location data
    distanceFilter: 100, //minimum distance (measured in meters) a
    //device must move horizontally before an update event is generated;
  );
  StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
      locationSettings: locationSettings).listen((Position position) {
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457
    location=Location(Latitude: position.latitude.toString(), Longitude: position.longitude.toString());
    long = position.longitude.toString();
    String lat = position.latitude.toString();
  });
}
Future<void> _InsertData() async {

  final db = Mysql();
  DateTime dateTime=DateTime.now();

//  print(userId);
  await db.getConnection().then(

        (conn) async {

      await conn.query(

          'insert into attendancehistory (StudentId,LectureId,Date,Latitude,Longitude,MethodId) values (?, ?, ?, ?, ?, ?)',

          [studentid,lectureid,dateTime.toString(),location.Latitude,location.Longitude,1]);

      await conn.close();

    },

  );

}
class _PasswordReadPageState extends State<PasswordReadPage> {
  final _sayiOdakNoktasi = FocusNode();

  @override
  void dispose() {
    _sayiKontrolcu.dispose();
    _sayiOdakNoktasi.dispose();
    super.dispose();
  }
  Future<void> Ins() async {
    getmySQLData().then((value) {
      if (_switchValue){
        if (_sayiKontrolcu.text == pass) {

              print("location" + location.Latitude);
              if (double.parse(latmax) >= (double.parse(location.Latitude)) &&
                  (double.parse(latmin)) <= (double.parse(location.Latitude)) &&
                  double.parse(longmax) >= (double.parse(location.Longitude)) &&
                  (double.parse(longmin)) <=
                      (double.parse(location.Longitude))) {
                _InsertData().then((value) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                            'Yoklama başarıyla alındı,\n İyi dersler!'),
                        ///////--------------Bu kısımda sayı doğru olsa bile gps konumunda olmazsa yok yazmamız gerekli
                        content: Text(''),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Tamam'),
                          ),
                        ],
                      );
                    },
                  );
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => const StudentMainPageView()));
                });
              } else {
                print("Konym hatası");
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                          'Konum hatası'),
                      ///////--------------Bu kısımda sayı doğru olsa bile gps konumunda olmazsa yok yazmamız gerekli
                      content: Text('Konumunuz doğrulanamadı'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Tamam'),
                        ),
                      ],
                    );
                  },
                );
              }

        }
        else {
          print("yanlış şifre");
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                    'Şifre yanlış'),
                ///////--------------Bu kısımda sayı doğru olsa bile gps konumunda olmazsa yok yazmamız gerekli
                content: Text('Şifreyi yanlış girdiniz.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Tamam'),
                  ),
                ],
              );
            },
          );
        }
    }
      else{
        if (_sayiKontrolcu.text == pass) {

                _InsertData().then((value) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                            'Yoklama başarıyla alındı,\n İyi dersler!'),
                        ///////--------------Bu kısımda sayı doğru olsa bile gps konumunda olmazsa yok yazmamız gerekli
                        content: Text(''),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Tamam'),
                          ),
                        ],
                      );
                    },
                  );
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => const StudentMainPageView()));
                });
              }
        else {
          print("yanlış şifre");
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                    'Şifre yanlış'),
                ///////--------------Bu kısımda sayı doğru olsa bile gps konumunda olmazsa yok yazmamız gerekli
                content: Text('Şifreyi yanlış girdiniz.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Tamam'),
                  ),
                ],
              );
            },
          );
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsItems.light,
      appBar: AppBar(
        title: const Text('Şifre İle Yoklama'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
              width: 200,
              child: TextField(
                cursorColor: Colors.black,
                controller: _sayiKontrolcu,
                focusNode: _sayiOdakNoktasi,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Sayı girin',
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Ins();

              },
              child: const Text(
                'Onayla',
                style: TextStyle(color: Colors.black),
              ),
            ),


        ],
        ),
      ),
    );
  }
}

class DortKategoriTab extends StatefulWidget {
  @override
  _DortKategoriTabState createState() => _DortKategoriTabState();
}

class _DortKategoriTabState extends State<DortKategoriTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Future<void> readySharedPreferences() async{
    var sharedPreferences = await SharedPreferences.getInstance();
    studentid = sharedPreferences.getInt("StudentId") ?? 0;
    lectureid = sharedPreferences.getInt("LectureId") ?? 0;

    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    readySharedPreferences();
  Getgps();
    getLocation();

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('4 Kategori TabLayout'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Kategori 1'),
            Tab(text: 'Kategori 2'),
            Tab(text: 'Kategori 3'),
            Tab(text: 'Kategori 4'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text('Kategori 1 içeriği')),
          Center(child: Text('Kategori 2 içeriği')),
          Center(child: Text('Kategori 3 içeriği')),
          Center(child: Text('Kategori 4 içeriği')),
        ],
      ),
    );
  }
}
