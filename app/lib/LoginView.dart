import 'package:flutter/material.dart';
import 'package:flutter_wycorder/flutter_wycorder.dart';
import 'package:wycorder/DashboardView.dart';
import 'package:wycorder/main.dart';
import 'globals.dart' as globals;

class LoginView extends StatefulWidget {
  final String baseURL;
  LoginView({Key key, this.baseURL}): super(key: key);
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  _LoginData _data = _LoginData();
  bool _submitIsDisabled = false;
  @override
  Widget build(BuildContext context) {
    _initPrefs();
    return Scaffold(
      body: Container( child:Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(  
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(topLeft:Radius.circular(15), topRight: Radius.circular(15))
              ),
              child: Center(
                child: Text('Login', style: Theme.of(context).textTheme.headline3,),
              )
            ),
            Container( 
              decoration: BoxDecoration(  
                borderRadius: BorderRadius.only(bottomLeft:Radius.circular(15), bottomRight: Radius.circular(15)),
                color: Colors.grey[200],
              ),
              child: Form( 
                key: _formKey,
                child: 
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(  
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(  
                          hintText: 'email or ID',
                          labelText: 'Username'
                        ),
                        onSaved: (newValue) {
                          this._data.username = newValue;
                        },
                      ),
                      TextFormField(  
                        obscureText: true,
                        decoration: InputDecoration(  
                          hintText: 'password',
                          labelText: 'Password',
                        ),
                        onSaved: (newValue) {
                          this._data.password = newValue;
                        },
                      ),
                      Container( 
                        child: RaisedButton(
                          child: Text('Login'),
                          onPressed: () {
                            this._submit();
                          },
                        )
                      )
                    ],
                  ),
                ),
              )
            )
          ]
        ),
      )
      )
    );
  }

  bool checkDisabled() {
    if (this._submitIsDisabled == true) {
      return null;
    } else {
      return this._submitIsDisabled;
    }
  }

  void _submit() {
    _formKey.currentState.save();
    // Check to make sure data is valid
    if (this._data.username != '' || this._data.password != '') {
      if (!this._data.username.contains('  ')) {
        // Disable the button
        FlutterWycorder connection = FlutterWycorder(this.widget.baseURL);
        SystemUser user = SystemUser();
        connection.authenticate(this._data.username, this._data.password).then((value) {
          user = value;
          if (user.system_user_id != null) {
            globals.user = user;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardView(title: 'Dashboard', user: user)));
          } else {
            // Something went wrong
            print('Something went wrong logging in.');
            setState(() {
              this._submitIsDisabled = false;
            });
          }
        }).catchError((err) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(err.message))
          );
        });
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Do not press tab in fields.'))
      );
      }
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Please fill out all the fields.'))
      );
    }
  }

  Future<bool> _initPrefs() async {
    //globals.preferences = await StreamingSharedPreferences.instance;
  }

}


class _LoginData {
  String username = '';
  String password = '';
}