import 'package:flutter/material.dart';
import 'package:wycorder/reading.dart';
import 'package:wycorder/widgets/ReadingTile.dart';
import 'package:flutter_wycorder/flutter_wycorder.dart';
import 'package:wycorder/globals.dart' as globals;

class Dashboard extends StatelessWidget {

  Dashboard({Key key, this.status, this.connection, this.readings, this.user, this.parent}) : super(key: key);

  final String status;
  final String connection;
  final List<Reading> readings;
  final SystemUser user;
  final State parent;

  Color statusColor = Colors.teal;
  IconData statusIcon = Icons.check;
  IconData connectionIcon = Icons.power;
  String connectionStatus = 'Connected';


  @override
  Widget build(BuildContext context) {
    _preInit();
    return Stack(
      children: [Column(
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  width: 250,
                  height: 250,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: this.statusColor,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column( 
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Current Status", style: Theme.of(context).textTheme.headline6),
                      Icon(this.statusIcon, size: 60),
                      Text(this.status, style: Theme.of(context).textTheme.headline6),
                    ]
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column( 
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Connection", style: Theme.of(context).textTheme.headline6),
                      Icon(this.connectionIcon, size: 60),
                      Text(this.connectionStatus, style: Theme.of(context).textTheme.headline6),
                    ]
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: this.readings.length,
              itemBuilder: (context, index) {
                return ReadingTile(timeTaken: this.readings[index].time_taken, status: this.readings[index].status,);
              },
            )
          ),
          Container( 
            height: 35,
            color: Colors.transparent,
          )
        ],
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 35,
          decoration: BoxDecoration( 
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10), ),
            color: Theme.of(context).colorScheme.primary,
          ),
        )
      ),
      Align( 
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: FlatButton(
          color: Colors.grey[700],
          shape: CircleBorder(),
          child: Icon(Icons.add, size: 60, color: Colors.white,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReadingPage(title: 'New Screening', user: this.user,)),
            ).then((value) => {
              this.parent.setState(() {
                print('Added New Reading');
              })
            });
          },
        ),
        )
      ),
      ]
    );
  }

  void _preInit() {
    switch (this.status) {
      case 'Pass': {
        this.statusColor = Colors.green[300];
        this.statusIcon = Icons.check;
      }
      break;
      case 'Warn': {
        this.statusColor = Colors.amber[300];
        this.statusIcon = Icons.warning;
      }
      break;
      case 'Fail': {
        this.statusColor = Colors.red[300];
        this.statusIcon = Icons.error;
      }
      break;
      default: {
        this.statusColor = Colors.grey;
        this.statusIcon = Icons.error;
      }
    }

    // Connection
    if (this.connection != null) {
      this.connectionIcon = Icons.power;
      this.connectionStatus = this.connection;
    } else {
      this.connectionIcon = Icons.power;
      this.connectionStatus = 'Not connected';
    }

  }


}