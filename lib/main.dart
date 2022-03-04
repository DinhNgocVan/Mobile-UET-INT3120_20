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
    return MaterialApp(
      title: 'My First App',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(title: 'Hello'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:Text('Ocean series'),),
        body: ListView(
          shrinkWrap: true, padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          children: <Widget> [
            Image.asset('assets/girl.jpg'),
            Product(
              name: "Cat",
              description: "Cat with ocean",
              price: 800,
              image: '1.jpg'
            ),
            Product(
              name: "Cold",
              description: "Cold in ocean",
              price: 2000,
              image: "2.jpg"
            ),
            Product(
              name: "Ocean",
              description: "Ocean in your eyes",
              price: 1500,
              image: "3.jpg"
            ),
            Product(
            name: "Blue",
            description: "Deep blue",
            price: 100,
            image: "4.jpg"
            ),
          ]
      )
    );
  }
}

class RatingBox extends StatefulWidget {
  @override
  _RatingBoxState createState() =>
      _RatingBoxState();
}
class _RatingBoxState extends State<RatingBox> {
  int _rating = 0;
  void _setRatingAsOne() {
    setState( () {
      _rating = 1;
    });
  }
  void _setRatingAsTwo() {
    setState( () {
      _rating = 2;
    });
  }
  void _setRatingAsThree() {
    setState( () {
      _rating = 3;
    });
  }
  Widget build(BuildContext context) {
    double _size = 20;
    print(_rating);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_rating >= 1 ? Icon(Icons.star, size: _size,) :
            Icon(Icons.star_border, size: _size,)),
            color: Colors.red[500],
            onPressed: _setRatingAsOne,
            iconSize: _size,
          ),
        ),
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_rating >= 2 ? Icon(Icons.star, size: _size,) :
            Icon(Icons.star_border, size: _size,)),
            color: Colors.red[500],
            onPressed: _setRatingAsTwo,
            iconSize: _size,
          ),
        ),
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_rating >= 3 ? Icon(Icons.star, size: _size,) :
            Icon(Icons.star_border, size: _size,)),
            color: Colors.red[500],
            onPressed: _setRatingAsThree,
            iconSize: _size,
          ),
        ),
      ],
    );
  }
}


class Product extends StatelessWidget {
  const Product({Key? key, required this.name, required this.description, required this.price, required this.image}) : super(key: key);
  final String name;
  final String description;
  final int price;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2), height: 120,  child: Card(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
          Image.asset("assets/" +image, width: 200, height: 100,), Expanded(
              child: Container(
                  padding: EdgeInsets.all(5), child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Text(this.name, style: TextStyle(fontWeight: FontWeight.bold)), Text(this.description),
                  Text("Price: " + this.price.toString()), RatingBox(),
                ],
              )
              )
          )
        ]
        )
    )
    );
  }
}





//use snippet to get the code quicker. Example: stful = stateful


