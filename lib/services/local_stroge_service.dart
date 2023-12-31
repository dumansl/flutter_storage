import 'package:flutter_storage/model/my_models.dart';

abstract class LocalStorageService {
  Future<void> saveData(UserInformation userInformation);
  Future<UserInformation> readData();
}
