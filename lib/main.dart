// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Container(
            /*height: 100.0,
            width: 100.0,
            color: Colors.yellow,*/
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 10.0, color: Colors.pink),
                left: BorderSide(width: 10.0, color: Colors.pink),
                right: BorderSide(width: 10.0, color: Colors.pink),
                bottom: BorderSide(width: 10.0, color: Colors.pink),
              ),
            ),
            child: Container(
              padding: const
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 10.0, color: Colors.lightBlue),
                  left: BorderSide(width: 10.0, color: Colors.lightBlue),
                  right: BorderSide(width: 10.0, color: Colors.lightBlue),
                  bottom: BorderSide(width: 10.0, color: Colors.lightBlue),
                ),
                color: Colors.yellow,
              ),
              child: const Text(
                  'Hello World',textAlign: TextAlign.center, style: TextStyle(color: Colors.black, letterSpacing: 10.0, fontSize: 30,),
                  textDirection: TextDirection.ltr,
              ),
            ),
          ),
          /*Text(wordPair.asPascalCase,
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                     ),*/
                //load image
                 /*Icon(
                   Icons.favorite,
                   color: Colors.pink,
                   size: 100.0,
                   semanticLabel: 'Text to announce in accessibility modes',
                 ),*/
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const <Widget>[
                      Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 24.0,
                        semanticLabel: 'Text to announce in accessibility modes',
                      ),
                      Icon(
                        Icons.favorite_border,
                        color: Colors.green,
                        size: 30.0,
                      ),
                    ],
                  )*/
        ),
      ),
    );
  }
}




//use snippet to get the code quicker. Example: stful = stateful


