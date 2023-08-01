import 'dart:convert';

import 'address.dart';
import 'course.dart';

class Student {
  int? id;
  String name;
  int? age;
  List<String> nameCourses;
  List<Course> courses;
  Address address;

  Student(
      {this.id,
      required this.name,
      this.age,
      required this.nameCourses,
      required this.courses,
      required this.address});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'id': id,
      'name': name,
      'age': age ?? 0,
      'nameCourses': nameCourses,
      'courses': courses.map((courseMap) => courseMap.toMap()).toList(),
      'address': address.toMap(),
    };

    /*if (age != null) {
      map['age'] = age;
    }*/

    return map;
  }

  String toJson() => jsonEncode(toMap());

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
        id: map['id'] ?? 0,
        name: map['name'] ?? '',
        age: map['age'] ?? 0,
        nameCourses: List<String>.from(map['nameCourses'] ?? <String>[]).toList(),
        courses: map['courses']
        .map<Course>((courseMap) => Course.fromMap(courseMap))
        .toList() ?? <Course>[],
        address: Address.fromMap(map['address'] ?? <String, dynamic>{}),
    );
  }
  factory Student.fromJson(String json) => Student.fromMap(jsonDecode(json));
}
