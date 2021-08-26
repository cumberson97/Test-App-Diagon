import 'dart:ui';

import 'package:diagon_app/Models/Course.dart';
import 'package:diagon_app/loadData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Models/Student.dart';

/*void addStudent(context, List<Student> list) {
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
    return StudentForm(list: list);
  }));
}*/

class StudentForm extends StatefulWidget {
  List<Student> list;
  StudentForm({required this.list});
  @override
  StudentFormState createState() => StudentFormState(list: list);
}

class StudentFormState extends State<StudentForm> {
  List<Student> list;
  int counter = 1;
  StudentFormState({required this.list});

  final _key = GlobalKey<FormState>();
  int id = 0, age = 0;

  String name = '';
  Course holder = Course(courseCode: '', courseTitle: '');
  List<Course> courses = [];

  Widget build(BuildContext context) {
    // final kBoard = MediaQuery.of(context).viewInsets.bottom != 0;

    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, list);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("New Student Form"),
          ),
          body: SingleChildScrollView(
              child: Container(
                  child: Builder(
                      builder: (context) => Form(
                          key: _key,
                          child: Column(children: [
                            Text("Student Details",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            customText(),
                            courseList(),
                            submitButton()
                          ]))))),
        ));
  }

  Widget submitButton() {
    Student student;
    return Padding(
        padding: EdgeInsets.all(1),
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.purple[600],
            ),
            onPressed: () {
              final form = this._key.currentState;
              if (form!.validate()) {
                form.save();
                setState(() {
                  //print("${holder.courseCode}");
                  courses.add(holder);
                  student =
                      Student(name: name, id: id, age: age, courses: courses);

                  list.add(student);
                  form.reset();
                  DataLoader.addStudent(student);
                });
              }
            },
            icon: Icon(Icons.check_circle),
            label: Text('Submit')));
  }

  Widget courseList() {
    return Padding(
      padding: EdgeInsets.all(6),
      child: Column(
        children: [
          Text("Courses", style: TextStyle(fontWeight: FontWeight.bold)),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: counter,
              itemBuilder: (context, index) {
                return newTile();
              }),
          Padding(
              padding: EdgeInsets.all(4),
              child: Row(children: [
                Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple[600],
                        ),
                        onPressed: () {
                          setState(() {
                            if (counter > 1) {
                              courses.remove(holder);
                              counter = counter - 1;
                            } else {}
                          });
                        },
                        icon: Icon(Icons.remove_circle_sharp),
                        label: Text('Remove Course'))),
                Padding(
                    padding: EdgeInsets.only(left: 45),
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple[600],
                        ),
                        onPressed: () {
                          final form = this._key.currentState;
                          setState(() {
                            if (counter < 5) {
                              if (form!.validate()) {
                                form.save();
                                courses.add(holder);
                              }
                              counter = counter + 1;
                            } else {}
                          });
                        },
                        icon: Icon(Icons.add_circle_sharp),
                        label: Text('   Add Course   ')))
              ]))
        ],
      ),
    );
  }

  Widget newTile() {
    return Column(children: [
      Padding(
          padding: EdgeInsets.symmetric(vertical: 9),
          child: TextFormField(
              decoration: InputDecoration(
                hintText: 'TEST1234',
                labelText: "Course Code",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Input needed';
                } else {
                  return null;
                }
              },
              onSaved: (val) => setState(
                  () => holder.courseCode = val.toString().toUpperCase()))),
      Padding(
          padding: EdgeInsets.all(4),
          child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Name of Course',
                labelText: "Course Title",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0)),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Input needed';
                } else {
                  return null;
                }
              },
              onSaved: (val) =>
                  setState(() => holder.courseTitle = val.toString())))
    ]);
  }

  Widget customText() {
    return Padding(
        padding: EdgeInsets.all(4),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.all(4),
              child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    labelText: "Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Input needed';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val) => setState(() => name = val.toString()))),
          Padding(
              padding: EdgeInsets.all(4),
              child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'ID number',
                    labelText: "Student ID",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Input needed';
                    } else {
                      for (final i in list) {
                        if (i.id == int.parse(value.toString())) {
                          return 'ID alredy exist';
                        }
                      }
                      return null;
                    }
                  },
                  onSaved: (val) =>
                      setState(() => id = int.parse(val.toString())))),
          Padding(
              padding: EdgeInsets.all(4),
              child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Age",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Input needed';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val) =>
                      setState(() => age = int.parse(val.toString()))))
        ]));
  }
}
