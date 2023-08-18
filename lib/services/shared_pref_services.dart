import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/services/local_stroge_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService implements LocalStorageService {
  late final SharedPreferences preferences;

  SharedPreferenceService() {
    init();
  }

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<void> saveData(UserInformation userInformation) async {
    final _name = userInformation.name;
    final preferences = await SharedPreferences.getInstance();

    preferences.setString("name", _name);
    preferences.setBool("student", userInformation.isStudent);
    preferences.setInt("gender", userInformation.gender.index);
    preferences.setStringList("colors", userInformation.colors);
  }

  @override
  Future<UserInformation> readData() async {
    var _name = preferences.getString("name") ?? "";
    var _student = preferences.getBool("student") ?? false;
    var _gender = Gender.values[preferences.getInt("gender") ?? 0];
    var _colors = preferences.getStringList("colors") ?? <String>[];
    return UserInformation(
        name: _name, gender: _gender, colors: _colors, isStudent: _student);
  }
}
