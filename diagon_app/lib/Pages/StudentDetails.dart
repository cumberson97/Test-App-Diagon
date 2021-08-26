import 'package:diagon_app/Models/Course.dart';
import 'package:diagon_app/Models/Student.dart';
import 'package:diagon_app/Pages/AddCourse.dart';
import 'package:diagon_app/loadData.dart';
import 'package:flutter/material.dart';

void readDetails(Student student, context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
    return StudentDetails(student: student);
  }));
}

class StudentDetails extends StatefulWidget {
  Student student;
  StudentDetails({required this.student});

  @override
  StudentDetailsState createState() => StudentDetailsState(student: student);
}

class StudentDetailsState extends State<StudentDetails> {
  Student student;

  StudentDetailsState({required this.student});

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Student Details'),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.grey])),
          child: columnMoved(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple[700],
          child: Icon(
            Icons.control_point_rounded,
            color: Colors.grey[400],
          ),
          onPressed: () async {
            setState(() async {
              student = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddCourse(student: student)));
            });
          },
        ));
  }

  Widget columnMoved() {
    return Column(children: <Widget>[
      Card(
          child: ListTile(
              title: Text(
                student.name,
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
              ),
              subtitle: Text('''ID:${student.id}
Age:${student.age}''', textAlign: TextAlign.center))),
      Expanded(
        child: ListView.builder(
            itemCount: student.courses.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Card(
                      child: ListTile(
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            final course = student.courses[index];
                            DataLoader.deleteCourse(course, student.id);
                            student.courses.remove(course);
                          });
                        }),
                    title: Text('Title: ${student.courses[index].courseTitle}'),
                    subtitle: Text(
                        'Code: ${student.courses[index].courseCode.toUpperCase()}'),
                  ))
                ],
              );
            }),
      )
    ]);
  }
}

void back(context) {
  Navigator.pop(context);
}
