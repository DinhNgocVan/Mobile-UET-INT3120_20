import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/db.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() => runApp(MyApp());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

Stream<QuerySnapshot> fetchItems() {
  return FirebaseFirestore.instance.collection('item').snapshots();
}

class Product {
  final String name;
  final String description;
  final String image;
  Product(this.name, this.description, this.image);

  static List<Product> getProducts() {
    List<Product> items = <Product>[];
    items.add(
        Product(
            "Go on a date",
            "Dating~",
            '1.jpg'
        )
    );
    items.add(
        Product(
            "Go to school",
            "I will have a Math test today",
            '2.jpg'
        )
    );
    items.add(
        Product(
            "Raining",
            "Remember to bring an umbrella",
            '3.jpg'
        )
    );
    items.add(
        Product(
            "Wash clothes",
            "It's time to wash clothes",
            '4.jpg'
        )
    );
    return items;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Animation<double>? animation;

  AnimationController? controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller!);
    controller!.forward();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'My First App',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: MyHomePage(title: 'Hello', animation: animation),
      debugShowCheckedModeBanner: false,
    );
  }

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required this.animation}) : super(key: key);

  final String title;
  final Animation<double>? animation;
  final items = Product.getProducts();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Note Me"),),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: ProductBox(item: items[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(item: items[index]),
                  ),
                );
              },
            );
          },
        )
    );
  }
}

class ProductPage extends StatelessWidget {
  ProductPage({Key ? key, required this.item}) : super(key: key);
  final Product item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.item.name),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/" + this.item.image,height: 100.0,width: MediaQuery.of(context).size.width,),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.name, style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(this.item.description),
                            Text("Important:"),
                            RatingBox(),
                          ],
                        )
                    )
                )
              ]
          ),
        ),
      ),
    );
  }
}
class RatingBox extends StatefulWidget {
  @override
  _RatingBoxState createState() => _RatingBoxState();
}
class _RatingBoxState extends State<RatingBox> {
  int _rating = 0;
  void _setRatingAsOne() {
    setState(() {
      _rating = 1;
    });
  }
  void _setRatingAsTwo() {
    setState(() {
      _rating = 2;
    });
  }
  void _setRatingAsThree() {
    setState(() {
      _rating = 3;
    });
  }
  void _setRatingAsFour() {
    setState(() {
      _rating = 4;
    });
  }
  void _setRatingAsFive() {
    setState(() {
      _rating = 5;
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
            icon: (
                _rating >= 1 ? Icon(
                  Icons.star,
                  size: _size,
                )
                    : Icon(
                  Icons.star_border,
                  size: _size,
                )
            ),
            color: Colors.red[500],
            onPressed: _setRatingAsOne,
            iconSize: _size,
          ),
        ),
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (
                _rating >= 2 ?
                Icon(
                  Icons.star,
                  size: _size,
                )
                    : Icon(
                  Icons.star_border,
                  size: _size,
                )
            ),
            color: Colors.red[500],
            onPressed: _setRatingAsTwo,
            iconSize: _size,
          ),
        ),
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (
                _rating >= 3 ?
                Icon(
                  Icons.star,
                  size: _size,
                )
                    : Icon(
                  Icons.star_border,
                  size: _size,
                )
            ),
            color: Colors.red[500],
            onPressed: _setRatingAsThree,
            iconSize: _size,
          ),
        ),
      ],
    );
  }
}
class ProductBox extends StatelessWidget {
  ProductBox({Key ? key, required this.item}) : super(key: key);
  final Product item;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 140,
        child: Card(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset("assets/" + this.item.image),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.name, style: TextStyle(fontWeight: FontWeight.bold)), Text(this.item.description),
                            Text("Important:"),
                            RatingBox(),
                          ],
                        )
                    )
                )
              ]
          ),
        )
    );
  }
}
