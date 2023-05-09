import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:untitled1/Models/Location.dart';

import '../mysql.dart';
import '../student_main_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({Key? key}) : super(key: key);

  @override
  _QrScanScreenState createState() => _QrScanScreenState();
}
String pass="";
String latmax="";
String latmin="";
String longmax="";
String longmin="";
int studentid=0;
int lectureid=0;
bool _switchValue=false;
Future<void> getmySQLData() async {

  var db = Mysql();

  String sql =  "select * from attendancedata where MethodId='2' and Date_Add(AttendanceDate,interval 10 minute)>Date_Add(UTC_TIMESTAMP(),interval 3 hour)";

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

          [studentid,lectureid,dateTime.toString(),location.Latitude,location.Longitude,2]);

      await conn.close();

    },

  );

}

class _QrScanScreenState extends State<QrScanScreen> {
  String data = "";

  void scanQrCode() {
    FlutterBarcodeScanner.scanBarcode("#000000", "Cancel", true, ScanMode.QR).then((value) {
      setState(() {
        this.data = value;



      });

    }).then((value) {
    Ins();
    });
  }

  Future<void> readySharedPreferences() async{
    var sharedPreferences = await SharedPreferences.getInstance();
    studentid = sharedPreferences.getInt("StudentId") ?? 0;
    lectureid = sharedPreferences.getInt("LectureId") ?? 0;

    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    Getgps();
    getLocation();
    readySharedPreferences();
   // scanQrCode();
  }
  Future<void> Ins() async {
    getmySQLData().then((value) {
      if (_switchValue){
        if (data == pass) {

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
        if (data == pass) {

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
      appBar: AppBar(title: Text("Qr Code Tarat"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: () {
                scanQrCode();

              },
              child: const Text(
                'Tarat',
                style: TextStyle(color: Colors.black),
              ),
            ),


          ],
        ),
      ),

    );
  }
}