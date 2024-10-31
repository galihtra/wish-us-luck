import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserName(String name) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userName', name);
}
