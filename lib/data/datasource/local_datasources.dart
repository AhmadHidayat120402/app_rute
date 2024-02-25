import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  static const String id = "id";
  static const String nama = "nama";

  static saveId(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LocalDataSource.id, value);
  }

  static Future<String> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString(LocalDataSource.id);
    return id.toString();
  }

  static saveNama(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LocalDataSource.nama, value);
  }

  static Future<String> getNama() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nama = prefs.getString(LocalDataSource.nama);
    return nama.toString();
  }

  Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("token", token);
  }

  Future<String> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('token') ?? "";
  }

  Future<void> removeToken() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('token');
  }
}
