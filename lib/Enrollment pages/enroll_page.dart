import 'package:flutter/material.dart';
import 'package:untitled1/login%20pages/login_student.dart';
import '/login%20pages/login_teacher.dart';
import 'enroll_student.dart';

class EnrollPage extends StatelessWidget {
  const EnrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageView();
  }
}

class PageView extends StatelessWidget {
  const PageView({super.key});

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
              'Merhaba',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25, /*fontStyle:*/
              ),
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
                width: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/anıt.png')),
              ),
              const SizedBox(
                height: 50,
                width: 100,
              ),
              const SizedBox(
                  width: 250, height: 50, child: StudentElevatedButton()),
              const SizedBox(height: 20),
              const SizedBox(
                  width: 250, height: 50, child: TeacherElevatedButton()),
              const SizedBox(
                height: 150,
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
    );
  }
}

class StudentElevatedButton extends StatelessWidget {
  const StudentElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const StudentLoginPage())),

      style: ElevatedButton.styleFrom(
          backgroundColor: ColorsItems.buttonBackgroundYellow),
      //BORDER RADIUS EKLE - YUVARLAK KENARLI BUTON
      //BUTONA OUTLINE EKLE
      child: const Text(
        'Öğrenci Girişi',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

class TeacherElevatedButton extends StatelessWidget {
  const TeacherElevatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //Performans iyileştirmesi için arka planda açılan sayfaları kapatmak gerekiyor
        //Mert Kök Sayfalar arası geçiş 2 videonun son kısmı kaynak olarak kullanabilirsin.
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TeacherLoginPage()));
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: ColorsItems.buttonBackgroundYellow),
      child: const Text(
        'Eğitmen Girişi',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

class ColorsItems {
  static const Color light = Color(0xffFEF2C7);
  static const Color littleDark = Color(0xffFCE58E);
  static const Color buttonBackgroundYellow = Color(0xffFACB1E);
  static const Color dividerBlack = Colors.black;
}
