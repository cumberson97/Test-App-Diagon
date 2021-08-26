import 'package:diagon_app/loadData.dart';
import 'package:flutter/material.dart';
import 'dataList.dart';
import 'dart:io';

class CourseApp extends StatefulWidget {
  @override
  CourseAppState createState() => CourseAppState();
}

class CourseAppState extends State<CourseApp> {
  final _formkey = GlobalKey<FormState>();
  String email = '', key = '';
  bool visible = true;
  bool v = false;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Course Manager')),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.grey.shade300, Colors.purple.shade200])),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Builder(
            builder: (context) => Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(15),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0)),
                              hintText: 'example@example.com',
                              prefixIcon: Icon(Icons.mail)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please input email';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) =>
                              setState(() => email = val.toString()),
                        )),
                    Padding(
                        padding: EdgeInsets.all(15),
                        child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0)),
                                suffixIcon: IconButton(
                                  icon: visible
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  onPressed: () =>
                                      setState(() => visible = !visible),
                                )),
                            obscureText: visible,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please input Password';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) =>
                                setState(() => key = val.toString()))),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 100.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple[600],
                        ),
                        child: Text('Login'),
                        onPressed: () async {
                          final form = _formkey.currentState;
                          if (form!.validate()) {
                            form.save();
                            //print('Testing for value $key');
                            //v = await auth(key, email);
                            //sleep(Duration(seconds: 5));
                            v = true;
                            if (v) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DataPage()));
                              form.reset();
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content:
                                      Text('Incorrect Email or Password')));
                            }
                          } else {
                            //form.reset();

                          }
                        },
                      ),
                    )
                  ],
                )),
          )),
    );
  }

  Future<bool> auth(String pass, String email) async {
    if (pass != null && email != null) {
      final v2 = await DataLoader.auth(email, pass).then((value) {
        return value;
      });

      return v2;
    }
    return false;
  }
}
