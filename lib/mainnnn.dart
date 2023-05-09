import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'Models/StudentModel.dart';

import 'mysql.dart';

import 'package:geolocator/geolocator.dart';


void main() {

  runApp(const MyApp());

}


class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);



  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Flutter mySQL CRUD Demo',

      theme: ThemeData(

        primarySwatch: Colors.blue,

      ),

      home: const MyHomePage(title: 'Flutter MySQL CRUD Demo Home Page'),

    );

  }

}




class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;


  @override

  State<MyHomePage> createState() => _MyHomePageState();

}


Future<String> Getgps() async{
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

     long = position.longitude.toString();
    String lat = position.latitude.toString();
  });
  return long;
}
Future<List<StudentModel>> getmySQLData() async {

  var db = Mysql();

  String sql = 'select * from Students;';


  final List<StudentModel> mylist = [];

  await db.getConnection().then((conn) async {

    await conn.query(sql).then((results) {

      for (var res in results) {

        //print(res);

        // mylist.add(res['user_Id'].toString());

        // mylist.add(res['username'].toString());

        // mylist.add(res['email'].toString());

        final StudentModel myuser = StudentModel(


            StudentName: res['StudentName'].toString(),

            StudentPassword: res['StudentPassword'].toString(), StudentSurname: res['StudentSurname'].toString(),StudentPhoneNumber: res['StudentPhoneNumber'].toString(),StudentSchoolNumber: res['StudentSchoolNumber'].toString());

        mylist.add(myuser);

      }

    }).onError((error, stackTrace) {

      print(error);

      return null;

    });

    conn.close();

  });


  return mylist;

}
Future<void> _InsertStudents(StudentModel studentModel) async {

  final db = Mysql();


//  print(userId);
    await db.getConnection().then(

        (conn) async {

      await conn.query(

          'insert into Students (StudentName, StudentSurname, StudentPhoneNumber, StudentSchoolNumber, StudentPassword) values (?, ?, ?, ?, ?)',

          [studentModel.StudentName, studentModel.StudentSurname, studentModel.StudentPhoneNumber,studentModel.StudentSchoolNumber,studentModel.StudentPassword]);

      await conn.close();

    },

  );

}
void Generetor(){
  var rndnumber="";
  var rnd= new Random();
  for (var i = 0; i < 6; i++) {
    rndnumber = rndnumber + rnd.nextInt(9).toString();
  }
}
class _MyHomePageState extends State<MyHomePage> {

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(widget.title),

      ),

      body: Center(

        child: showFutureDBData(),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: submitAction(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),

    );

  }

}

submitAction(BuildContext context) {
//StudentModel studentModel=new StudentModel(StudentId: StudentId, StudentName: StudentName, StudentSurname: StudentSurname, StudentPhoneNumber: StudentPhoneNumber, StudentSchoolNumber: StudentSchoolNumber, StudentPassword: StudentPassword)
  //_InsertStudents(studentModel);


}
showFutureDBData() {

  return FutureBuilder<List<StudentModel>>(

    future: getmySQLData(),

    builder: (BuildContext context, snapshot) {

      if (snapshot.connectionState == ConnectionState.waiting) {

        return const CircularProgressIndicator();

      } else if (snapshot.hasError) {

        return Text(snapshot.error.toString());

      }

      return ListView.builder(

        itemCount: snapshot.data!.length,

        itemBuilder: (context, index) {

          final user = snapshot.data![index];

          return ListTile(

            leading: Text(user.StudentSchoolNumber.toString()),

            title: Text(user.StudentName),

            subtitle: Text(user.StudentPassword),

          );

        },

      );

    },

  );

}