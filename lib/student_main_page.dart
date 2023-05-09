import 'package:flutter/material.dart';
import 'package:untitled1/Drawer%20Pages/notifications_page.dart';
import 'package:untitled1/Drawer%20Pages/profile.dart';
import 'package:untitled1/voiceyeni.dart';
import '/Enrollment%20pages/enroll_page.dart';
import '/main%20pages/history_page.dart';
import '/main%20pages/password_read_page.dart';
import '/main%20pages/qr_read_page.dart';
import '/main%20pages/voice_listen_page.dart';


class StudentMainPageView extends StatelessWidget {
  const StudentMainPageView({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StudentMainPage(title: 'Öğrenci paneli'),
    );
  }
}

class StudentMainPage extends StatefulWidget {
  const StudentMainPage({super.key, required this.title});
  final String title;

  @override
  State<StudentMainPage> createState() => _StudentLoginPageState();
}

class _StudentLoginPageState extends State<StudentMainPage> {
  int _counter = 0;

  void _incrementCounter() {
    // Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [

        ],
        title: Column(
          children: [
            const Text(
              'Ana Menü',
              style: TextStyle(color: Colors.black),
            ),
            Image.asset(
              "assets/anıt.png",
              width: 24,
              height: 24,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffFCE49B),
      ),
      body: const Design(),

      ///////DRAWER -----------------------------------
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 250, 250, 245),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            ListTile(
              leading: const Icon(Icons.apps),
              title: const Text(' Ana Menü '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StudentMainPageView()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text(' Hesabım '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_active),
              title: const Text(' Bildirimler '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  NotificationPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(' Ayarlar '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.question_mark_outlined),
              title: const Text(' SSS '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.question_answer_outlined),
              title: const Text('Yardım'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

///////// BODY ---------------------
class Design extends StatelessWidget {
  const Design({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsItems.light,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QrReadPage())),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    side: const BorderSide(color: Colors.black, width: 5),
                    backgroundColor: Colors.blue,
                    fixedSize: const Size(150, 150),
                    elevation: 5,
                  ),
                  child: InkIcon('assets/qr_icon.png', 150, 150),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  HistoryPage(title: 'Geçmiş',))),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    side: const BorderSide(color: Colors.black, width: 5),
                    backgroundColor: Colors.green,
                    fixedSize: const Size(150, 150),
                    elevation: 5,
                  ),
                  child: InkIcon('assets/history_icon.png', 150, 150),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PasswordReadPage())),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.black, width: 5),
                    ),
                    backgroundColor: Colors.red,
                    fixedSize: const Size(150, 150),
                    elevation: 5,
                  ),
                  child: InkIcon('assets/password.png', 140, 140),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VoiceMainPage(title: 'Sesle Doğrulama',))),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.black, width: 5),
                    ),
                    backgroundColor: Colors.orange,
                    fixedSize: const Size(150, 150),
                    elevation: 5,
                  ),
                  child: InkIcon('assets/ses_icon.png', 150, 150),
                ),
              ],
            ),
          ),
          SizedBox(
              height: 30, width: 200, child: Image.asset('assets/logo.png')),
          const SizedBox(
            width: 170,
            child: Divider(
              indent: 110,
              endIndent: 110,
              height: 10,
              color: ColorsItems.dividerBlack,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

///////// Icon ---------------------
  Ink InkIcon(String resim, double h, double w) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        constraints: const BoxConstraints(minWidth: 150, minHeight: 150),
        alignment: Alignment.center,
        child: Image.asset(
          resim,
          fit: BoxFit.cover,
          width: w,
          height: h,
        ),
      ),
    );
  }
}
