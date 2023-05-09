// enroll > verification page > login > main


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/Enrollment%20pages/enroll_student.dart';
import '../LectureSelection.dart';
import '../Models/StudentModel.dart';
import '../mysql.dart';
import '../teacher_main_page.dart';
import '/student_main_page.dart';
import '../Enrollment pages/enroll_page.dart';
import 'package:device_information/device_information.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherLoginPage extends StatelessWidget {
  const TeacherLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetTextFieldValue(),
    );
  }
}
String num="";
String pass="";
String id="";

String _platformVersion = 'Unknown',
    _imeiNo = "",
    _modelName = "",
    _manufacturerName = "",
    _deviceName = "",
    _productName = "",
    _cpuType = "",
    _hardware = "";
var _apiLevel;

Future<void> getmySQLData(BuildContext context) async {

  var db = Mysql();

  String sql =  "select * from instructors where InstructorUserName='"+num+"' and InstructorPassword='"+pass+"';";

  await db.getConnection().then((conn) async {
    var sharedPreferences = await SharedPreferences.getInstance();

    await conn.query(sql).then((results) {
      if(results.length!=0) {

        for (var res in results) {
          //print(res);

          // mylist.add(res['user_Id'].toString());

          // mylist.add(res['username'].toString());

          // mylist.add(res['email'].toString());
       //   id=res['StudentId'].toString();
        }

       // sharedPreferences.setString("StudentId", id);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TeacherMainPage()));
      }else{
        DialogExample();
        print("hata");
      }
    }).onError((error, stackTrace) {

      print(error);

      return null;

    });

    conn.close();

  });



}
class GetTextFieldValue extends StatefulWidget {

  _TextFieldValueState createState() => _TextFieldValueState();

}

//PageView dan extend edemedim.
class _TextFieldValueState extends State<GetTextFieldValue> {


  @override
  void initState() {
    super.initState();

  }

  // Platform messages are asynchronous, so we initialize in an async method.

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
              'Giriş Ekranı',
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
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          num = value;
                          print(num);
                        });
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Kullanıcı Adı'),
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
                          print(pass);
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
                    child:
                    SizedBox(width: 250, height: 50, child: LoginButton()),
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

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>  Login(context),

      style: ElevatedButton.styleFrom(
          backgroundColor: ColorsItems.buttonBackgroundYellow),
      //BORDER RADIUS EKLE - YUVARLAK KENARLI BUTON
      //BUTONA OUTLINE EKLE
      child: const Text(
        'Giriş Yap!',
        style: TextStyle(color: Colors.black),
      ),
    );

  }
}
void Login(BuildContext context){
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => TeacherMainPage()));
  // getmySQLData(context);
}
class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Hata'),
          content: const Text('Numara veya şifre yanlış.'),
          actions: <Widget>[

            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }}
