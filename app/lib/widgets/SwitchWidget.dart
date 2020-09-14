import 'package:flutter/material.dart';

class SwitchWidget extends StatefulWidget {
  bool value;
  String label;
  String name;
  SwitchWidget({Key key, this.name, this.label, this.value}):super(key:key);
  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Switch( 
        value: this.widget.value,
        onChanged: (value) {
          setState((){
            this.widget.value = value;
          });
        },
      ),
      title: Text(this.widget.label),
    );
  }
}