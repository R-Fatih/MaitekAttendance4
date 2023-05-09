import 'package:mysql1/mysql1.dart';



class Mysql {

  static String host = 'MYSQL8003.site4now.net',

      user = 'a979e3_maitek',

      password = 'a1s2d3f4g5',

      db = 'db_a979e3_maitek';

  static int port = 3306;


  Mysql();


  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(

        host: host,
        port: port,
        user: user,

        password: password,
        db: db);

    return await MySqlConnection.connect(settings);
  }

}