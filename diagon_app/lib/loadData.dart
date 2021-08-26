import 'dart:convert';

import 'package:diagon_app/Models/Course.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'Models/Student.dart';

class DataLoader {
  static Future<List<Student>> getStudentsApi(BuildContext context) async {
    final url = 'http://10.0.2.2:5000/Student';
    final response = await http.get(Uri.parse(url));
    List list = jsonDecode(response.body);
    List<Student> temp = [];
    for (var t in list) {
      temp.add(Student.fromJson(t));
    }
    return temp;
  }

  static void addStudent(Student student) async {
    print(json.encode(student.toJson()));
    final url = 'http://10.0.2.2:5000/Student';
    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(student.toJson()));
    } catch (e) {
      print("Error: $e");
    }
  }

  static void deleteStudent(Student student) async {
    print(json.encode(student.toJson()));
    final url = 'http://10.0.2.2:5000/Student';
    try {
      final response = await http.delete(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(student.toJson()));
    } catch (e) {
      print("Error: $e");
    }
  }

  static void deleteCourse(Course course, int id) async {
    print(json.encode(course.toJson()));
    final url = 'http://10.0.2.2:5000/Student/${id}';
    try {
      final response = await http.delete(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(course.toJson()));
    } catch (e) {
      print("Error: $e");
    }
  }

  static void addNewCourse(Student student) async {
    print(json.encode(student.toJson()));
    final url = 'http://10.0.2.2:5000/Student';
    try {
      final response = await http.put(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(student.toJson()));
    } catch (e) {
      print("Error: $e");
    }
  }

  static auth(String email, String pass) async {
    //print(json.encode(student.toJson()));
    final url = 'http://10.0.2.2:5000/Auth';
    try {
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'email': email, 'password': pass}));

      final body = jsonDecode(response.body);
      print('This is the response ${body['Value']}');

      return body['Value'];
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<List<Student>> getStudents(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    try {
      final data = await assetBundle.loadString('assets/Test_json.json');
      List body = jsonDecode(data);
      List<Student> temp = [];
      for (var t in body) {
        temp.add(Student.fromJson(t));
      }

      return temp;
    } catch (e) {
      print('Error: $e');
      List<Student> t = [];
      return t;
    }
  }
}
