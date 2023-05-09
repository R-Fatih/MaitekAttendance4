import 'package:flutter/material.dart';
import 'Enrollment pages/enroll_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const EnrollPage();
  }
}
