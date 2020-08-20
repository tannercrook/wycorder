import 'package:http/http.dart';

import 'Reading.dart';
import 'SystemUser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FlutterWycorder {

  String baseURL;
  String token;

  FlutterWycorder(this.baseURL, {this.token,});


  // Functions

  Future<SystemUser> authenticate(String username, String password) async {
    var body = json.encode({
      'username':username, 
      'password':password,
    });
    final response = await http.post(this.baseURL+'/auth', headers: {'content_type':'application/json'}, body: body);
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


  Future<SystemUser> getUser() async {
    final response = await http.get(this.baseURL+'/system_user/', headers: {'token':this.token});
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



