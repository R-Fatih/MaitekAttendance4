import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<String> notifications = [
    "Yeni bir mesajınız var",
    "Görevin son tarihi yaklaşıyor",
    "Etkinlik hatırlatıcısı",
    "Başka bir bildirim"
  ];

  Set<int> readNotifications = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bildirimler"),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.notifications),
            title: Text(
              notifications[index],
              style: TextStyle(
                fontWeight: readNotifications.contains(index)
                    ? FontWeight.normal
                    : FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "Bildirim detayları",
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: readNotifications.contains(index)
                    ? FontWeight.normal
                    : FontWeight.bold,
              ),
            ),
            onTap: () {
              setState(() {
                readNotifications.add(index);
              });
            },
          );
        },
      ),
    );
  }
}
