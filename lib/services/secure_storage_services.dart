import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/services/local_stroge_service.dart';

class SecureStorageService implements LocalStorageService {
  late final FlutterSecureStorage preferences;
  SecureStorageService() {
    preferences = const FlutterSecureStorage();
  }
  @override
  Future<void> saveData(UserInformation userInformation) async {
    final _name = userInformation.name;
    await preferences.write(key: "name", value: _name);
    await preferences.write(
        key: "student", value: userInformation.isStudent.toString());
    await preferences.write(
        key: "gender", value: userInformation.gender.index.toString());
    await preferences.write(
        key: "colors", value: jsonEncode(userInformation.colors));
  }

  @override
  Future<UserInformation> readData() async {
    var _name = await preferences.read(key: "name") ?? "";
    var _studentString = await preferences.read(key: "student") ?? "false";
    var _student = _studentString.toLowerCase() == "true" ? true : false;
    var _genderString = await preferences.read(key: "gender") ?? "0";
    var _gender = Gender.values[int.parse(_genderString)];
    var _colorsString = await preferences.read(key: 'colors');
    var _colors = _colorsString == null
        ? <String>[]
        : List<String>.from(jsonDecode(_colorsString));
    return UserInformation(
        name: _name, gender: _gender, colors: _colors, isStudent: _student);
  }
}
