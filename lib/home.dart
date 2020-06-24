import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:blogapp/pages/itemone.dart';
import 'package:blogapp/pages/itemthree.dart';
import 'package:blogapp/pages/itemtwo.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indexpage=1;
  final pageoption=[
   Itemone(),
   Itemtwo(),
   Itemthree()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageoption[_indexpage],
      bottomNavigationBar:  CurvedNavigationBar(
        backgroundColor: Color(0xFFea9085),
          index: 1,
          items: <Widget>[
            Icon(Icons.poll, size: 30),
            Icon(Icons.home, size: 30),
            Icon(Icons.library_books, size: 30)
          ],
        onTap: (int index){
          setState(() {
            _indexpage=index;
          });
        },
      ),
    );
  }
}
