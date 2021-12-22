import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sprouts',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(title: 'Sprouts'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _shouldRandomize = false;

  // store the framerate
  static const double framerate = 60;
  static const Duration frametime = Duration(milliseconds: 1000 ~/ framerate);
  late Timer _timer;
  static Random random = Random();
  static double x = 100;
  static double y = 100;
  static double maxX = 100, maxY = 100;

  @override
  void initState() {
    _timer = Timer.periodic(frametime, (result) {
      setState(() {
        if (_shouldRandomize) {
          // randomize the position of the object
          x = random.nextDouble() * maxX;
          y = random.nextDouble() * maxY;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (maxX == 100) {
      maxX = MediaQuery.of(context).size.width - 50;
      maxY = MediaQuery.of(context).size.height - 50;
    }
    return Scaffold(
      // check for tap
      body: Stack(
        children: [
          Positioned(
            left: x,
            top: y,
            child: Container(
              color: Colors.red,
              width: 50,
              height: 50,
            ),
          ),
          GestureDetector(
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                x = details.globalPosition.dx - 25;
                y = details.globalPosition.dy - 25;
              });
            },
            onTapDown: (TapDownDetails details) {
              // flip the boolean and update the app
              setState(() {
                x = details.globalPosition.dx - 25;
                y = details.globalPosition.dy - 25;
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
