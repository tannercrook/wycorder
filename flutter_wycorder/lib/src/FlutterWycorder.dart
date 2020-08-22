import 'Reading.dart';
import 'SystemUser.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class FlutterWycorder {

  String baseURL;
  String token;

  FlutterWycorder(this.baseURL, {this.token,});


  // Functions

  // login
  Future<SystemUser> authenticate(String username, String password) async {
    Map body = {"username":username, "password":password};
    final response = await http.post(this.baseURL+'/system_user/auth', headers: {HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",}, body: body);
    if (response.statusCode == 200) {
      SystemUser user = SystemUser.fromJson(json.decode(response.body));
      return user;
    } else if (response.statusCode == 403) {
      print('Access Denied');
      throw Exception('Access Denied');
    } else {
      print('Error fetching data');
      print(body.toString());
      print(this.baseURL+'/system_user/auth'+' '+response.statusCode.toString());
      throw Exception('Error fetching data');
    }
  }


  Future<SystemUser> getUser() async {
    final response = await http.get(this.baseURL+'/system_user/', headers: {HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",'token':this.token});
    if (response.statusCode == 200) {
      SystemUser user = SystemUser.fromJson(json.decode(response.body));
      return user;
    } else if (response.statusCode == 403) {
      print('Access Denied');
      throw Exception('Access Denied');
    } else {
      print('Error fetching data');
      throw Exception('Error fetching data');
    }
  }


  Future<List<Reading>> fetchReadings() async {
    final response = await http.get(this.baseURL+'/reading/', headers: {'token':this.token});
    if (response.statusCode == 200) {
      List<Reading> readings = (json.decode(response.body) as List).map((e) => Reading.fromJson(e)).toList();
      return readings;
    } else if (response.statusCode == 403) {
      print('Access Denied');
      throw Exception('Access Denied');
    } else {
      print('Error fetching data');
      throw Exception('Error fetching data');
    }
  }

  // Add a reading to the database
  Future<bool> putReading(Reading reading) async {
    var body = reading.toJson();
    final response = await http.put(this.baseURL+'/reading/', headers: {'token':this.token, HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",}, body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


  // This function will create some test data for the purpose of testing the application without having connectivity.
  static List<Reading> getTestData() {
    List<Reading> testingList = [];
    for (var i=10; i>=3; i--) {
      testingList.add( 
        Reading(readingID: i, system_user_id: 1, time_taken: DateTime(2020, 8, i), status: 'Pass')
      );
    }
    testingList.add( 
      Reading(readingID: 1, system_user_id: 1, time_taken: DateTime(2020, 8, 1), status: 'Fail')
    );
    testingList.add( 
      Reading(readingID: 2, system_user_id: 1, time_taken: DateTime(2020, 8, 2), status: 'Warn')
    );
    return testingList;

  }

}



