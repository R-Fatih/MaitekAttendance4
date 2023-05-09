import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled1/Enrollment%20pages/enroll_student.dart';

import 'mysql.dart';

class PasswordGeneratorPage extends StatefulWidget {
  const PasswordGeneratorPage({super.key});

  @override
  _PasswordGeneratorPageState createState() => _PasswordGeneratorPageState();
}

class _PasswordGeneratorPageState extends State<PasswordGeneratorPage> {
  String _password = '';
  DateTime dateTime=DateTime.now();

  Future<void> _Insert( ) async {

    final db = Mysql();


//  print(userId);
    await db.getConnection().then(

          (conn) async {

        await conn.query(

            'insert into attendancedata (InstructorId,LectureId,MethodId,MethodKey,AttendanceDate) values (?, ?, ?, ?, ?)',

            [1, 1, 1,pass,dateTime.toString()]);

        await conn.close();

      },

    );

  }

  void _generatePassword() {
    Random random = Random();
    int randomNumber = random.nextInt(9999 - 1000) + 1000;
    setState(() {
      _password = randomNumber.toString();
    });
  }
void Buttonclick(){
    _generatePassword();
    _Insert();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Password Generator',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffFCE49B),
      ),
      body: Center(
          child: Row(
            children: [
              for (int i = 0; i < 4; i++)
                Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      _password.isNotEmpty ? _password[i] : '',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: Buttonclick,
                child: Text('Generate'),
              ),
            ],
          )
      ),
    );
  }
}
