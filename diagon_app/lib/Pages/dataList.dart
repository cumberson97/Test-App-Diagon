import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Models/Student.dart';
import '../loadData.dart';
import 'StudentDetails.dart';
import 'StudentForm.dart';

class DataPage extends StatefulWidget {
  @override
  DataPageState createState() => DataPageState();
}

class DataPageState extends State<DataPage> {
  List<Student> list = [];
  List<Student> list2 = [];

  void initState() {
    DataLoader.getStudentsApi(context).then((value) {
      setState(() {
        list.addAll(value);
        list2 = list;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.grey])),
          child: buildList(list2)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[700],
        child: Icon(
          Icons.control_point_rounded,
          color: Colors.grey[400],
        ),
        onPressed: () {
          setState(() {
            //addStudent(context, list);
            waiting(context);
          });
        },
      ),
    );
  }

  Widget buildList(List<Student> students) => ListView.builder(
        itemCount: students.length + 1,
        itemBuilder: (context, index) {
          students.sort();

          return index == 0 ? searchbar() : tile(students[index - 1]);
        },
      );

  Widget searchbar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Search..',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
            prefixIcon: Icon(Icons.search)),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            list2 = list.where((list) {
              var name = list.name.toLowerCase();
              var id = list.id.toString();
              return name.contains(text) || id.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  Widget tile(Student student) {
    return Container(
        padding: EdgeInsets.all(1),
        child: Card(
          color: Colors.grey[100],
          child: ListTile(
              tileColor: Colors.grey[100],
              leading: CircleAvatar(
                backgroundColor: Colors.purple[600],
                child: Text(student.name[0]),
              ),
              title: Text(student.name),
              subtitle: Text(student.id.toString()),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      DataLoader.deleteStudent(student);
                      list.remove(student);
                    });
                  }),
              onTap: () => (readDetails(student, context))),
        ));
  }

  void waiting(BuildContext context) async {
    final list1 = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StudentForm(
                  list: list,
                )));

    setState(() {
      list = list1;
      list2 = list;
    });
  }
}
