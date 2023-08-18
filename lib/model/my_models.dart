import 'package:flutter/foundation.dart';

enum Gender { FEMALE, MALE, OTHER }

enum Color { YELLOW, BLUE, GREEN, PINK, MOR }

class UserInformation {
  final String name;
  final Gender gender;
  final List<String> colors;
  final bool isStudent;

  UserInformation({
    required this.name,
    required this.gender,
    required this.colors,
    required this.isStudent,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "gender": describeEnum(gender),
      "colors": colors,
      "isStudent": isStudent,
    };
  }

  UserInformation.fromjson(Map<String, dynamic> json)
      : name = json["name"],
        gender = Gender.values.firstWhere(
            (element) => describeEnum(element).toString() == json["gender"]),
        colors = List<String>.from(json["colors"]),
        isStudent = json["isStudent"];
}
