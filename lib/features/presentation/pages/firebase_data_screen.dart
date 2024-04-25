import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

class FirebaseDataScreen extends StatefulWidget {
  const FirebaseDataScreen({super.key});

  @override
  _FirebaseDataScreenState createState() => _FirebaseDataScreenState();
}

class _FirebaseDataScreenState extends State<FirebaseDataScreen> {
  final DatabaseReference _databaseReferenceLang =
  FirebaseDatabase.instance.ref().child('GPS/Latitude');
  final DatabaseReference _databaseReferenceLong =
  FirebaseDatabase.instance.ref().child('GPS/Longitude');
  String _latitude = 'Loading...';
  String _longitude = 'Loading...';

  @override
  void initState() {
    super.initState();
    // Listen for changes in the database
    _databaseReferenceLang.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          _latitude = event.snapshot.value.toString();

        });
      }
    });
    _databaseReferenceLong.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          _longitude = event.snapshot.value.toString();

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Data'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Latitude:',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _latitude,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Longitude:',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _longitude,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}