import 'Reading.dart';

class FlutterWycorder {

  FlutterWycorder();

  static List<Reading> getTestData() {
    List<Reading> testingList = [];
    for (var i=10; i>=3; i--) {
      testingList.add( 
        Reading(readingID: i, userGUID: 'DJSLK-KSJDL-WOKNF-LKSND', timeTaken: DateTime(2020, 8, i), status: 'Pass')
      );
    }
    testingList.add( 
      Reading(readingID: 1, userGUID: 'DJSLK-KSJDL-WOKNF-LKSND', timeTaken: DateTime(2020, 8, 1), status: 'Fail')
    );
    testingList.add( 
      Reading(readingID: 2, userGUID: 'DJSLK-KSJDL-WOKNF-LKSND', timeTaken: DateTime(2020, 8, 2), status: 'Warn')
    );
    return testingList;

  }

}



