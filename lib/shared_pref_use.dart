import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_storage/main.dart';
import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/services/local_stroge_service.dart';

class SharedPreferenceUse extends StatefulWidget {
  const SharedPreferenceUse({Key? key}) : super(key: key);

  @override
  State<SharedPreferenceUse> createState() => _SharedPreferenceUseState();
}

class _SharedPreferenceUseState extends State<SharedPreferenceUse> {
  var _currentGender = Gender.FEMALE;
  var _currentColor = <String>[];
  var _isStudent = false;
  final TextEditingController _nameController = TextEditingController();
  final LocalStorageService _preferenceService = locator<LocalStorageService>();
  // final LocalStorageService _preferenceService2 = SharedPreferenceService();
  // final LocalStorageService _preferenceService3 = SecureStorageService();

  @override
  void initState() {
    super.initState();
    _verileriOku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SharedPreference Use"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Adınızı Girin"),
            ),
          ),
          for (var item in Gender.values)
            _buildRadioListTitle(describeEnum(item), item),
          // _buildRadioListTitle("Female", Gender.FEMALE),
          // _buildRadioListTitle("Male", Gender.MALE),
          // _buildRadioListTitle("Other", Gender.OTHER),
          for (var item in Color.values) _buildCheckboxListTile(item),
          // _buildCheckboxListTile(Color.BLUE),
          // _buildCheckboxListTile(Color.GREEN),
          // _buildCheckboxListTile(Color.PINK),
          // _buildCheckboxListTile(Color.YELLOW),
          SwitchListTile(
              title: const Text("Is he/she student?"),
              value: _isStudent,
              onChanged: (bool? isStudent) {
                setState(() {
                  _isStudent = isStudent!;
                });
              }),
          TextButton(
              onPressed: () {
                var _userInformation = UserInformation(
                  name: _nameController.text,
                  gender: _currentGender,
                  colors: _currentColor,
                  isStudent: _isStudent,
                );
                _preferenceService.saveData(_userInformation);
              },
              child: const Text("Save"))
        ],
      ),
    );
  }

  Widget _buildRadioListTitle(String title, Gender gender) {
    return RadioListTile(
        title: Text(title),
        value: gender,
        groupValue: _currentGender,
        onChanged: (Gender? currentGender) {
          setState(() {
            _currentGender = currentGender!;
          });
        });
  }

  Widget _buildCheckboxListTile(Color color) {
    return CheckboxListTile(
      title: Text(describeEnum(color)),
      value: _currentColor.contains(describeEnum(color)),
      onChanged: (bool? value) {
        if (value == false) {
          _currentColor.remove(describeEnum(color));
        } else {
          _currentColor.add(describeEnum(color));
        }
        setState(() {});
        debugPrint(_currentColor.toString());
      },
    );
  }

  void _verileriOku() async {
    var info = await _preferenceService.readData();
    _nameController.text = info.name;
    _currentGender = info.gender;
    _currentColor = info.colors;
    _isStudent = info.isStudent;
    setState(() {});
  }
}
