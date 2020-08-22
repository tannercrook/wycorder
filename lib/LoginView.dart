import 'package:flutter/material.dart';
import 'package:flutter_wycorder/flutter_wycorder.dart';
import 'package:wycorder/DashboardView.dart';
import 'package:wycorder/main.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
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
      body: Column(
        children: [
          Center(
            child: Container( 
              decoration: BoxDecoration(  
                borderRadius: BorderRadius.circular(30),
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
          )
        ],
      ),
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
    // Disable the button
    FlutterWycorder connection = FlutterWycorder(this.widget.baseURL);
    SystemUser user = SystemUser();
    connection.authenticate(this._data.username, this._data.password).then((value) {
      user = value;
      if (user.system_user_id != null) {
        globals.user = user;
        globals.preferences.setString('token', globals.user.token);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardView(title: 'Dashboard', user: user)));
      } else {
        // Something went wrong
        print('Something went wrong logging in.');
        setState(() {
          this._submitIsDisabled = false;
        });
      }
    }).catchError((err) => print(err));
  }

  Future<bool> _initPrefs() async {
    globals.preferences = await StreamingSharedPreferences.instance;
  }

}


class _LoginData {
  String username = '';
  String password = '';
}