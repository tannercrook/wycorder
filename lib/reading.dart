import 'package:flutter/material.dart';
import 'package:tricorder/widgets/result.dart';



class ReadingPage extends StatefulWidget {
  ReadingPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  var switches = {
    'breath':false,
    'cough':false,
    'smellTaste':false,
    'tiredness':false,
    'exposure':false,
  };
  double temperature;
  final tempController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _save() {
    bool result = true;
    if (_formKey.currentState.validate()) {
      for (var check in switches.keys) {
        if (switches[check] == true) {
          result = false;
        }
      }
      Navigator.push(context, MaterialPageRoute(builder: (contxt) => ResultPage(result: result, switches: switches,)));
    }
    
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
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Self Screening", style: Theme.of(context).textTheme.headline2,),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Please fill out the information accurately.", style: Theme.of(context).textTheme.subtitle1,),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 20),
              child: Text("Toggle any of the following that you are experiencing.", style: Theme.of(context).textTheme.subtitle1,),
            ),
            ListTile(
              leading: Switch( 
                value: switches['breath'],
                onChanged: (value) {
                  setState((){
                    switches['breath'] = value;
                  });
                },
              ),
              title: Text("Shortness of breath"),
            ),
            ListTile(
              leading: Switch( 
                value: switches['cough'],
                onChanged: (value) {
                  setState((){
                    switches['cough'] = value;
                  });
                },
              ),
              title: Text("Coughing"),
            ),
            ListTile(
              leading: Switch( 
                value: switches['smellTaste'],
                onChanged: (value) {
                  setState((){
                    switches['smellTaste'] = value;
                  });
                },
              ),
              title: Text("Loss of smell and/or taste"),
            ),
            ListTile(
              leading: Switch( 
                value: switches['tiredness'],
                onChanged: (value) {
                  setState((){
                    switches['tiredness'] = value;
                  });
                },
              ),
              title: Text("Unusual Tiredness"),
            ),
            ListTile(
              leading: Switch( 
                value: switches['exposure'],
                onChanged: (value) {
                  setState((){
                    switches['exposure'] = value;
                  });
                },
              ),
              title: Text("Exposure"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 30),
              child: TextField(
                key: Key('tempField'),
                controller: tempController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration( 
                  icon: Icon(Icons.healing),
                  labelText: "Temperature"
                  ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _save,
        tooltip: 'Save',
        child: Icon(Icons.save),
      ), // This trai
    );
  }
}