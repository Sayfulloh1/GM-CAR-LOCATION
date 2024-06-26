import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'features/presentation/pages/firebase_data_screen.dart';
import 'features/presentation/pages/home_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CarLocationScreen(),
    ),
  );
}
