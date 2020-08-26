# WYcorder
WYcorder is a Flutter app and API that was built to help schools in Wyoming (or beyond) track COVID. Specifically it adheres to the guidelines set by the WHSAA for student athletes. 

![Screenshot](/flutter/screenshots/screenshot1.png?raw=true "Screenshot")

WYcorder was built with security in mind, so you can anonymize data as much as you would like. You also can host your own server (possibly internal only) to additionally safeguard data.

## Project Structure
The project consists of two main directories. The first is the Flutter directory that contains the flutter application resources. It can be used to compile for iOS, Android, web (javascript), and Linux Desktop. *note I only tested on Android, web, and Linux.* The Second is the REST API to manage authentication and logging. The API is built in FLASK.

## Installation

### Flutter
To compile for the flutter apps, follow the instructions on flutter.dev to get set up. Once you are ready, simply run `flutter build web` to compile for release or `flutter run -d linux` to run in debug mode (replacing the last parameter) for the device you want to compile for. There is a lot of documentation on flutter.dev about this.

### Flask API
To set up the API, you will need to initialize a PostgreSQL database on an accessible server. There is a script in `wycorder-api/database` that will create the database structures for you that match the objects in the sqlalchemy objects.

Once the database is created, you can set up the Flask service. My goto method is Ubuntu Server with Apache2 and WSGI. 

## Contributing
If you would like to contribute, please feel free to do so! 

## Notice
This code is delivered as-is with no guarantee, support, or liability. By using this code, you choose to do so at your own risk.
