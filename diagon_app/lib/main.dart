import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';
import 'Pages/Login_Page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap:
            /*FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }*/

            () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
            theme: ThemeData(primaryColor: Colors.purple[700]),
            home: CourseApp()));
  }
}
