import 'package:diagon_app/loadData.dart';
import 'package:flutter/material.dart';
import '../Models/Student.dart';
import '../Models/Course.dart';

class AddCourse extends StatefulWidget {
  Student student;
  AddCourse({required this.student});
  @override
  AddCourseState createState() => AddCourseState(student: student);
}

class AddCourseState extends State<AddCourse> {
  Student student;
  Course course = Course(courseCode: '', courseTitle: '');
  final _key = GlobalKey<FormState>();
  AddCourseState({required this.student});

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, student);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Student Details"),
        ),
        body: Container(
            color: Colors.purple[700],
            child: Builder(
              builder: (context) => Form(
                  key: _key,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 50, 15, 50),
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(250),
                          ),
                          color: Colors.grey[400]!.withAlpha(450),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "Add Course",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'TEST1234',
                                          labelText: "Course Code",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0)),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Input needed';
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (val) => setState(() {
                                              course.courseCode =
                                                  val.toString().toUpperCase();
                                            }))),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'TEST1234',
                                          labelText: "Course Title",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0)),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Input needed';
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (val) => setState(() {
                                              course.courseTitle =
                                                  val.toString();
                                            }))),
                                Padding(
                                    padding: EdgeInsets.all(4),
                                    child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.purple[600],
                                        ),
                                        onPressed: () {
                                          final form = this._key.currentState;
                                          if (form!.validate()) {
                                            form.save();
                                            setState(() {
                                              student.courses.add(course);
                                              form.reset();
                                              DataLoader.addNewCourse(student);
                                              Navigator.pop(context, student);
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.add_circle_sharp),
                                        label: Text('   Submit   ')))
                              ])))),
            )),
      ),
    );
  }
}
