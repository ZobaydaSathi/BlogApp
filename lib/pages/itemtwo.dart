import 'package:blogapp/pages/itemone.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Itemtwo extends StatefulWidget {
  @override
  _ItemtwoState createState() => _ItemtwoState();
}

class _ItemtwoState extends State<Itemtwo> {
  Future getItemTwo()async{
    var firestore=Firestore.instance;
    QuerySnapshot snap=await firestore.collection('HomeData').getDocuments();
    return snap.documents;
  }
  Future<Null>getRefresh()async{
    await Future.delayed(Duration(seconds:3));
    setState(() {
      getItemTwo();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFFea9085),
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Material(
                      elevation: 14.0,
                      color: Color(0xFFfcf8e8),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),topRight: Radius.circular(5.0),
                       bottomLeft:Radius.circular(5.0),bottomRight:Radius.circular(5.0) ),
                      shadowColor: Color(0xFFfc9d9d),
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width -250,
                        padding: EdgeInsets.only(right:160),
                        margin: EdgeInsets.only(left: 5.0),
                        child: Icon(Icons.search,color: Colors.grey,),
                           ),
                         ),
                  ],
                ),
                 SizedBox(width: 5.0,),
                 Container(child: Text('Blog App',
                   style:
                    TextStyle(
                     color:Colors.white,fontWeight: FontWeight.bold,fontSize:25.0,
                    ),
                  ),
                 ),
                 SizedBox(width: 5.0),
                 Container(
                   child: IconButton(icon: Icon(Icons.menu,color: Colors.white,), onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Itemone()));
                 }, ),
                 ),
            ],
          )
      ),
      body: FutureBuilder(
        future: getItemTwo(),
        builder:(context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else{
            return RefreshIndicator(
              onRefresh: getRefresh,
              child: ListView.builder(
                itemCount: snapshot.data.length,
                  itemBuilder:(context,index) {
                  var ourData=snapshot.data[index];
                    return Column(
                      children: <Widget>[
                        Container(
                          height: 350,
                            margin: EdgeInsets.only(top: 40.0),
                            child:Material(
                              borderRadius: BorderRadius.circular(10.0),
                              elevation: 10.0,
                               shadowColor: Color(0xFFfc9d9d),
                               color: Color(0xFFfcf8e8),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height:200,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image: NetworkImage(ourData.data['image']),fit: BoxFit.cover),
                                        borderRadius:BorderRadius.circular(10.0)
                                      ),
                                    ),
                                    SizedBox(height: 5.0,),
                                    Row(
                                      children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 7.0),
                                        child: Text(ourData.data['title'],
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.0),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: 7.0),
                                          child: Text(ourData.data['subtitle'],
                                            style: TextStyle(
                                              fontSize: 15.0
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.all( 7.0),
                                          width: MediaQuery.of(context).size.width,
                                          child: Text(ourData.data['paragraph'],
                                            textAlign: TextAlign.justify,
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.grey
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(height: 15.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                            child:Row(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(left: 7.0),
                                                  child: Icon(Icons.share,color: Colors.black,),
                                                )
                                              ],
                                            ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(right: 7.0),
                                              child: Icon(FontAwesomeIcons.comment,color:Colors.black),
                                            ),
                                            SizedBox(width: 20.0,),
                                            Container(
                                              margin: EdgeInsets.only(right: 7.0),
                                              child: Icon(FontAwesomeIcons.heart,color: Colors.black,),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            )
                          ],
                        );
                      },
                  ),
                );
              }
           }
        ),
    );
  }
}
