import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReadingTile extends StatelessWidget {
  ReadingTile({Key key, this.timeTaken, this.status}) : super(key: key);
  final DateTime timeTaken;
  final String status;
  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.black;
    switch (this.status) {
      case 'Pass':
        statusColor = Colors.green;
        break;
      case 'Warn':
        statusColor = Colors.amber;
        break;
      case 'Fail':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.red;
    }
    return Card(
      child: Container( 
        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(DateFormat('MM/dd/yyyy h:mm a').format(this.timeTaken.toLocal()), style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 17),),
            Container( 
              width: 60,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
              decoration: BoxDecoration( 
                color: statusColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(this.status, style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white, fontSize: 16),),
            ),
          ],
        ),
      )
    );
  }
}