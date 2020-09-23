import 'package:flutter/material.dart';
import './HomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(StartApp());
}

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.redAccent,
      ),
      home: HomePage(),
    );
  }
}
