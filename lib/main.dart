import 'package:flutter/material.dart';
import 'package:flutter_train_app/Seat/seat_page.dart';
import 'package:flutter_train_app/home/home_page.dart';
import 'package:flutter_train_app/station_list/station_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
