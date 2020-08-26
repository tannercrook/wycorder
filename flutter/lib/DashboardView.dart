import 'package:flutter/material.dart';
import 'package:wycorder/widgets/Dashboard.dart';
import 'package:flutter_wycorder/flutter_wycorder.dart';
import 'globals.dart' as globals;

class DashboardView extends StatefulWidget {
  DashboardView({Key key, this.title, this.user}) : super(key: key);
  final String title;
  final SystemUser user;
  @override
  _DashboardViewState createState() => _DashboardViewState();
}


class _DashboardViewState extends State<DashboardView> {


  @override
  Widget build(BuildContext context) {
    if (globals.addedNewReading) {
      setState(() {
        print('Set State');
      });
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(Icons.sync),
                onPressed: () {
                  setState(() {
                    
                  });
                },
              )
            )
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30)
            )
          ),
        ),
        body: FutureBuilder<List<Reading>>(
          future: FlutterWycorder(globals.apiBaseURL, token: this.widget.user.token).fetchReadings(),
          builder: (BuildContext context, AsyncSnapshot<List<Reading>> snapshot) {
            String latestStatus;
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                latestStatus = snapshot.data[0].status;
              } else {
                latestStatus = 'Pass';
              }
              return Dashboard(status: latestStatus, connection: 'Wycorder', readings: snapshot.data, user: this.widget.user, parent: this,);
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Error Loading. Restart the application.');
            } else {
              return Container( 
                child: CircularProgressIndicator(),
                height: 60,
                width: 60,
              );
            }
          },
        )
      );
  }
}

//  Dashboard(status: 'Pass', connection: null, readings: FlutterWycorder.getTestData(),),