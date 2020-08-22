import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:flutter_wycorder/flutter_wycorder.dart';

StreamingSharedPreferences preferences;
String apiBaseURL = 'https://wycorder.crooktec.com/api/v1';
SystemUser user = SystemUser();
bool addedNewReading = false;