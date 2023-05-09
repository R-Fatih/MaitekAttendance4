import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/Models/StudentModel.dart';
import 'package:untitled1/main2.dart';
import '../login pages/login_student.dart';
import '../mysql.dart';
import '/verification_page.dart';
import 'enroll_page.dart';
import 'package:flutter/services.dart';
import 'package:device_information/device_information.dart';

void main() => runApp(EnrollStudent());

class EnrollStudent extends StatelessWidget {  const EnrollStudent({super.key});

@override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
            ),
            body: Center(
                child: GetTextFieldValue()
            )
        )
    );
  }
}
StudentModel studentModel="" as StudentModel;

class GetTextFieldValue extends StatefulWidget {

  _TextFieldValueState createState() => _TextFieldValueState();

}
String name =  "";

String surname =  "";
String tel =  "";
String num =  "";
String pass =  "";
String _platformVersion = 'Unknown',
    _imeiNo = "",
    _modelName = "",
    _manufacturerName = "",
    _deviceName = "",
    _productName = "",
    _cpuType = "",
    _hardware = "";
var _apiLevel;
String stuid="";
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
Future<void> _InsertIMEI() async {

  final db = Mysql();


//  print(userId);
  await db.getConnection().then(

        (conn) async {

      await conn.query(

          'insert into imeidata (StudentId,IMEI) values (?,?)',

          [stuid,_imeiNo ]);

      await conn.close();

    },

  );

}
Future<void> getmySQLData() async {

  var db = Mysql();

  String sql =  "select * from students where StudentSchoolNumber='"+num+"'";

  await db.getConnection().then((conn) async {

    await conn.query(sql).then((results) {

      for (var res in results) {
        //print(res);
        stuid=res['StudentId'].toString();
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

class _TextFieldValueState extends State<GetTextFieldValue> {

  Future<void> initPlatformState() async {
    late String platformVersion,
        imeiNo = '',
        modelName = '',
        manufacturer = '',
        deviceName = '',
        productName = '',
        cpuType = '',
        hardware = '';
    var apiLevel;
    // Platform messages may fail,
    // so we use a try/catch PlatformException.
    try {
      platformVersion = await DeviceInformation.platformVersion;
      imeiNo = await DeviceInformation.deviceIMEINumber;
      modelName = await DeviceInformation.deviceModel;
      manufacturer = await DeviceInformation.deviceManufacturer;
      apiLevel = await DeviceInformation.apiLevel;
      deviceName = await DeviceInformation.deviceName;
      productName = await DeviceInformation.productName;
      cpuType = await DeviceInformation.cpuName;
      hardware = await DeviceInformation.hardware;
    } on PlatformException catch (e) {
      platformVersion = '${e.message}';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = "Running on :$platformVersion";
      _imeiNo = imeiNo;
      _modelName = modelName;
      _manufacturerName = manufacturer;
      _apiLevel = apiLevel;
      _deviceName = deviceName;
      _productName = productName;
      _cpuType = cpuType;
      _hardware = hardware;
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  String result = '';

  getTextInputData() {
    setState(() {
      studentModel=new StudentModel( StudentName: name, StudentSurname: surname, StudentPhoneNumber: tel, StudentSchoolNumber: num, StudentPassword: pass);
   _InsertStudents(studentModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: ColorsItems.light,
        //
        appBar: AppBar(
          backgroundColor: ColorsItems.littleDark,
          title: const Center(
            child: Text(
              'Öğrenci Kayıt Ekranı',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25, /*fontStyle:*/
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 75,
                    width: 100,
                  ),
                  AspectRatio(
                    aspectRatio: 16 / 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset('assets/anıt.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 100,
                  ),
                   Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: SizedBox(
                      width: 250,
                      height: 50,
                      child: TextField(
                        obscureText: false,
                        onChanged: (value) {
                          setState(() {
                            name = value;
                            print(name);
                          });
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            border: OutlineInputBorder(),
                            labelText: 'İsim'),
                      ),
                    ),
                  ),
                   SizedBox(
                    width: 250,
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                      setState(() {
                        surname = value;
                      });
                    },
                      obscureText: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Soyisim'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 250,
                      height: 50,
                      child: TextField(
                        onChanged: (value) {
                        setState(() {
                          tel = value;
                        });
                      },
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: const InputDecoration(
                            hintText: 'Başında sıfır olmadan giriniz',
                            border: OutlineInputBorder(),
                            labelText: 'Telefon No'),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                      setState(() {
                        num = value;
                      });
                    },
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Öğrenci No'),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                      width: 250,
                      height: 50,
                      child: TextField(onChanged: (value) {
                        setState(() {
                          pass = value;
                        });
                      },
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Şifre'),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: SizedBox(
                        width: 250, height: 50, child: EnrollmentButton()),
                  ),
                  const SizedBox(
                    height: 50,
                    width: 100,
                  ),
                  SizedBox(
                      height: 30,
                      width: 200,
                      child: Image.asset('assets/logo.png')),
                  const SizedBox(
                    width: 170,
                    child: Divider(
                      height: 10,
                      color: ColorsItems.dividerBlack,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }

}
class EnrollmentButton extends StatelessWidget {
  const EnrollmentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>     submitAction(context),

      style: ElevatedButton.styleFrom(
          backgroundColor: ColorsItems.buttonBackgroundYellow),
      //BORDER RADIUS EKLE - YUVARLAK KENARLI BUTON
      //BUTONA OUTLINE EKLE
      child: const Text(
        'Kayıt Ol!',
        style: TextStyle(color: Colors.black),
      ),
    );
  }  
  void submitAction(BuildContext context) {
    print("burada");
    studentModel=new StudentModel( StudentName: name, StudentSurname: surname, StudentPhoneNumber: tel, StudentSchoolNumber: num, StudentPassword: pass);
    _InsertStudents(studentModel).then((value) {
      getmySQLData().then((value) {
        _InsertIMEI().then((value) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
              const StudentLoginPage()));
        });
      });
    });


  }

}
