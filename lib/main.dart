import 'package:flutter/material.dart';
import 'package:tricorder/DashboardView.dart';
import 'package:flutter_wycorder/flutter_wycorder.dart';
import 'package:tricorder/LoginView.dart';
import 'package:tricorder/reading.dart';


import 'globals.dart' as globals;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wycorder',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        canvasColor: Colors.grey[300]
      ),
      home: MyHomePage(title: 'Wycorder'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _takeReading() {
    Navigator.push(context, MaterialPageRoute(builder: (contxt) => ReadingPage(title: 'New Reading')));
  }

  @override
  Widget build(BuildContext context) {
    Widget loginView = LoginView(baseURL: globals.apiBaseURL,);
    Widget dashboard = DashboardView(status: 'Fail', connection: null, readings: FlutterWycorder.getTestData(),);
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.person)
            )
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30)
            )
          ),
        ),
        body: dashboard,
      );
  }

  @override 
  void initState() {
    super.initState();
    if (globals.user.token == null) {
      _loginAndReturn(context);
    }
  }

  _loginAndReturn(BuildContext context) async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginView(baseURL: globals.apiBaseURL)));
  }

}
