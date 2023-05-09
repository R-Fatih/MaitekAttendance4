import 'package:flutter/material.dart';
import '/Drawer%20Pages/notifications_page.dart';
import '/Drawer%20Pages/profile.dart';
import '/Enrollment%20pages/enroll_page.dart';
import '/password_generator_page.dart';

void main() {
  runApp(const TeacherMainPage());
}

class TeacherMainPage extends StatelessWidget {
  const TeacherMainPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StudentMainPage(title: 'Flutter Demo Home Page'),
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
          CircleAvatar(
            backgroundColor: Colors.black45,
            child: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                // IconButton'a tıklanınca yapılacak işlemler burada yazılır.
              },
            ),
          ),
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
            DrawerHeader(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/pp.png',
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                  color: const Color(0xffCDB456),
                  border: Border.all(width: 5, color: Colors.black)),
              child: const Text(
                'Kullanıcı İsmi',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.apps),
              title: const Text(' Ana Menü '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TeacherMainPage()),
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
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
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
                  MaterialPageRoute(builder: (context) => NotificationPage()),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PasswordGeneratorPage())),
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
