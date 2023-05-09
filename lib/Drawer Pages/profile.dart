import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '/Enrollment%20pages/enroll_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  String university = "Konya Food and Agriculture University";
  String department = "Computer Science";
  String year = "2. Sınıf";
  String password = "**********";

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

//// Şifre değiştirme penceresi ----------
  void _changePassword(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Şifreni Değiştir"),
            content: TextField(
              obscureText: true,
              decoration:
                  const InputDecoration(hintText: "Yeni şifrenizi giriniz"),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("İptal"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Perform password change logic here
                },
                child: const Text("Kaydet"),
              ),
            ],
          );
        });
  }

//// Üniversite değiştirme penceresi ----------
  void _changeUniversity(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Okuduğunuz Üniversite"),
            content: TextField(
              obscureText: false,
              decoration:
                  const InputDecoration(hintText: "Üniversitenizi giriniz"),
              onChanged: (value) {
                setState(() {
                  university = value;
                });
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("İptal"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Perform password change logic here
                },
                child: const Text("Kaydet"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        backgroundColor: ColorsItems.littleDark,
        title: const Text("Hesabım", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _getImage,
              child: const CircleAvatar(
                radius: 50,

                ///////// Profil fotoğrafı eklenmemişse default icon ata, eklemek istenildiğinde de galeriye ve kameraya yönlendir -------
              ),
            ),
            const SizedBox(height: 20),
            Text(
              university,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              department,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              year,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text("Şifreni değiştir"),
              onTap: () {
                _changePassword(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Profil Fotoğrafını Değiştir"),
              onTap: _getImage,
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text("Üniversite Bilgisi"),
              onTap: () {
                _changeUniversity(context);
                // Perform university change logic here
              },
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text("Bölüm Bilgisi"),
              onTap: () {
                // Perform department change logic here
              },
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text("Sınıf bilgisi"),
              onTap: () {
                // Perform year change logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
