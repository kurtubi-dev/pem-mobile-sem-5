import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stack Widget'),
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                color: Colors.green,
                width: 100.0,
                height: 100.0,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                color: Colors.red,
                width: 100.0,
                height: 100.0,
              ),
            ),
            Positioned(
              top: 150,
              right: 50,
              child: Container(
                color: Colors.blue,
                width: 100.0,
                height: 100.0,
              ),
            ),
            Positioned(
              bottom: 200,
              left: 200,
              child: Container(
                color: Colors.black,
                width: 100.0,
                height: 100.0,
              ),
            ),
            Positioned(
              bottom: 200,
              left: 0,
              child: Container(
                color: Colors.yellow,
                width: 100.0,
                height: 100.0,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                color: Colors.pink,
                width: 100.0,
                height: 100.0,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                color: Colors.teal,
                width: 100.0,
                height: 100.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}