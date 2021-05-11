import 'package:flutter/material.dart';

import 'calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ('MaliTakvim2021Demo'),
      home: Calendar(),
    );
  }
}




