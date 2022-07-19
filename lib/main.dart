// ignore_for_file: unused_field

import 'package:crud_flutter/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ASD());
}

class ASD extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  ASD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("erroe occured");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              home: Material(
                child: HomePage(),
              ),
            );
          }
          return CircularProgressIndicator();
        });
  }
}
