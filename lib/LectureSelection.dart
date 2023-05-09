import 'package:flutter/material.dart';
import 'package:untitled1/student_main_page.dart';

import '../Enrollment pages/enroll_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mysql.dart';

void main() {
  runApp(LectureSelection());

}
String studentid="";
late List<String> items = ["Calculus II"];
Future<void> getmySQLData() async {

  var db = Mysql();

  String sql =  "select * from lectures";

  await db.getConnection().then((conn) async {

    await conn.query(sql).then((results) {

      for (var res in results) {
        //print(res);
        items.add(res['LectureName'].toString());
        // mylist.add(res['user_Id'].toString());

        // mylist.add(res['username'].toString());

        // mylist.add(res['email'].toString());


      }
    }
    ).onError((error, stackTrace) {

      print(error);

      return null;

    });

    conn.close();
  });



}

class LectureSelection extends StatefulWidget {
  @override
  _DortKategoriTabState createState() => _DortKategoriTabState();
}

class _DortKategoriTabState extends State<LectureSelection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Future<void> readySharedPreferences() async{
    var sharedPreferences = await SharedPreferences.getInstance();
    studentid = sharedPreferences.getString("StudentId")!;
    setState(() {});
  }
  int countreload=0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    getmySQLData().then((value) {

      if(countreload==0)
        {

        }
      countreload++;
    });
    readySharedPreferences();
    print(items.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
void TapLecture(int id)async{
  var sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setInt("LectureId", (id+1));
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => StudentMainPageView()));
}
void Reload(){
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => super.widget));
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsItems.littleDark,
          title: const Center(
            child: Text(
              "Ders Seçimi",
              style: TextStyle(
                  color: Colors.black,

              ),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(items[index]),
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(items[index][0]),
              ),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
TapLecture(index);
print(index);
              },
            );
          },
        ),
      ),
    );
  }
}
