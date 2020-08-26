import 'package:flutter/material.dart';
import 'package:flutter_wycorder/flutter_wycorder.dart';
import 'package:wycorder/widgets/result.dart';
import 'globals.dart' as globals;



class ReadingPage extends StatefulWidget {
  ReadingPage({Key key, this.title, this.user}) : super(key: key);
  final String title;
  final SystemUser user;
  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> with RouteAware{
  List<SwitchItem> switches = [
    SwitchItem(name: 'fever_chills', label: 'Fever/Chills', value: false),
    SwitchItem(name: 'cough', label: 'Cough', value: false),
    SwitchItem(name: 'sore_throat', label: 'Sore Throat', value: false),
    SwitchItem(name: 'short_breath', label: 'Shortness of Breath', value: false),
    SwitchItem(name: 'fatigue', label: 'Fatigue', value: false),
    SwitchItem(name: 'aches', label: 'Head/Muscle/Body Aches', value: false),
    SwitchItem(name: 'taste_loss', label: 'Loss of Taste/Smell', value: false),
    SwitchItem(name: 'congestion', label: 'Congestion/Runny Nose', value: false),
    SwitchItem(name: 'nausea_vomit_diarrhea', label: 'Nausea/Vomitting/Diarrhea', value: false),
    SwitchItem(name: 'infectious_contact', label: 'Close contact to COVID-19', value: false),
    SwitchItem(name: 'temperature', label: 'Temperature Above 100.4', value: false),
  ];
  Map<String, int> switchMap = {'finished': 1};
  double temperature;
  final tempController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _boolToInt(bool b) {
    if (b) {
      return 1;
    } else {
      return 0;
    }
  }

  void _save() {
    bool result = true;
    for (var item in switches) {
      switchMap[item.name] = _boolToInt(item.value);
      if (item.value == true) {
        result = false;
      }
    }
    String status;
    if (result) {
      status = 'Pass';
    } else {
      status = 'Fail';
    }
    Reading reading = Reading(
      readingID: null,
      system_user_id: this.widget.user.system_user_id,
      status: status,
      fever_chills: switchMap['fever_chills'],
      cough: switchMap['cough'], 
      sore_throat: switchMap['sore_throat'],
      short_breath: switchMap['short_breath'],
      fatigue: switchMap['fatigue'],
      aches: switchMap['aches'],
      taste_loss: switchMap['taste_loss'],
      congestion: switchMap['congestion'],
      nausea_vomit_diarrhea: switchMap['nausea_vomit_diarrhea'],
      infectious_contact: switchMap['infectious_contact'],
      temperature: switchMap['temperature'],
    );
    FlutterWycorder(globals.apiBaseURL, token: this.widget.user.token).putReading(reading);
    globals.addedNewReading = true;

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (contxt) => ResultPage(result: result, switches: null,)));
  
  }


  @override
  void dispose() {
    tempController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30)
          )
        ),
      ),
      body: Column(  
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 5),
            child: Text("Toggle any of the following that you are experiencing.", style: Theme.of(context).textTheme.subtitle1,),
          ),
          Divider(),   
          Expanded(
            child:ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              children: makeToggles(),
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _save,
        tooltip: 'Save',
        child: Icon(Icons.check),
      ), // This trai
    );
  }

  List<Widget> makeToggles() {
    List<Widget> toggles =[];
    for (var item in this.switches) {
      toggles.add(ListTile(
      leading: Switch( 
        value: item.value,
        onChanged: (value) {
          setState((){
            item.value = value;
          });
        },
      ),
      title: Text(item.label),
    ));
    }
    return toggles;
  }

}


class SwitchItem {
  String name;
  String label;
  bool value;
  Widget toggle;

  SwitchItem({this.name, this.label, this.value, this.toggle});

}