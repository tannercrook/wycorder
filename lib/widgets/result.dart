import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  ResultPage({Key key, this.result, this.switches}) : super(key: key);
  bool result;
  Map switches;
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>{
  Color fgColor = Colors.greenAccent;
  Color bgColor = Colors.green[300];

  Widget _child = Center(child: Icon(Icons.error, size: 100,));
  double _height = 250;
  double _width = 250;

  IconData _icon = Icons.check;
  BorderRadius _radius = BorderRadius.circular(30);

  String _response = "You're all set!";

  double _visible = 0;

  @override 
  void initState() {
    super.initState();
    animate();
  }

  void animate() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _visible = 1.0;
        _width = 1000;
        _height = 1000;
        _radius = BorderRadius.zero;
        _child = Column(
          children: <Widget>[
            Icon(_icon, size: 75,),
            Padding( 
              padding: EdgeInsets.all(10),
              child: AnimatedOpacity(
                child:Text(_response, style: Theme.of(context).textTheme.headline3,),
                opacity: _visible,
                duration: Duration(seconds: 3),
              ),
            )
          ],);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!this.widget.result) {
      fgColor = Colors.redAccent;
      bgColor = Colors.red[300];
      _icon = Icons.error;
      _response = "Please quarantine.";
    }
    _child = Column(
      children: <Widget>[
        Center(child: Icon(_icon, size: 75,),),
        Padding( 
          padding: EdgeInsets.all(10),
          child: AnimatedOpacity(
            child:Text(_response, style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.white),),
            opacity: _visible,
            duration: Duration(seconds: 3),
            curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)
          ),
        )
      ],
    );
    
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          Center(
            child: AnimatedContainer(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: _radius,
              ),
              duration: Duration(seconds: 4),
              curve: Curves.fastOutSlowIn,
              child: _child
            ),
          ),
        ],
      ),
    );
  }
}
