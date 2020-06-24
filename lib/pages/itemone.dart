import 'package:blogapp/home.dart';
import 'package:blogapp/pages/itemthree.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Itemone extends StatefulWidget {
  static const String id='itemone';
  @override
  _ItemoneState createState() => _ItemoneState();
}

class _ItemoneState extends State<Itemone> {
  Future getItemOne()async{
    var firestore=Firestore.instance;
    QuerySnapshot snap=await firestore.collection('ItemOne').getDocuments();
    return snap.documents;
  }
  Future<Null>getRefresh()async{
    await Future.delayed(Duration(seconds:3));
    setState(() {
      getItemOne();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFea9085),
          centerTitle:true,
          title: Text('Blog App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search,color: Colors.white,))
        ],
        ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('PencilBox'),
              accountEmail: Text('username@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/pencil.png'),
              ),
              decoration: BoxDecoration(
                color: Color(0xFFea9085)
              ),
            ),
            ListTile(
              title: Text('Page One',
                style: TextStyle(
                  color: Color(0xFFf64b3c),
                ),
              ),
              leading:Icon(Icons.poll,color:Color(0xFFf64b3c)),
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Itemone())),
            ),
            ListTile(
              title: Text('Home Page'),
              leading:Icon(Icons.home),
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Home())),
            ),
            ListTile(
              title: Text('Page Three'),
              leading:Icon(Icons.library_books),
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Itemthree())),
            ),
            Divider(height: 5.0),
            ListTile(
              title: Text('Communicate',
                style: TextStyle(
                    fontSize:18.0,
                    fontWeight:FontWeight.bold
                ),
              ),
            ),
            ListTile(
              title: Text('Share'),
              leading:Icon(Icons.share),
            ),
            ListTile(
              title: Text('Rate Us'),
              leading:Icon(FontAwesomeIcons.star),
            ),
            Divider(height: 5.0),
            ListTile(
              title: Text('Settings'),
              leading:Icon(Icons.settings),
            ),
            ListTile(
              title: Text('Logout'),
              leading:Icon(Icons.lock),
            ),
            ListTile(
              title: Text('Close',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              trailing:Icon(Icons.close),
              onTap:()=> Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: getItemOne(),
        builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else{
          return RefreshIndicator(
            onRefresh: getRefresh,
            child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder:(context,index) {
            var ourData=snapshot.data[index];
              return Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10.0),
                child: Material(
                  shadowColor: Color(0xFFfc9d9d),
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(ourData.data['image'],
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Text(ourData.data['title'],
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              margin: EdgeInsets.all(10.0),
                              child: Text(ourData.data['paragraph'],
                                maxLines: 8,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin:EdgeInsets.only(left: 10.0),
                                     child:Icon(Icons.person,size: 15.0,) ,
                                   ),
                                  SizedBox(width: 5.0),
                                  Container(
                                    child:Text('John Doe') ,
                                  ),
                                  SizedBox(width: 5.0),
                                  Container(
                                    child:Icon(FontAwesomeIcons.clock,size: 15.0,) ,
                                  ),
                                  SizedBox(width: 5.0),
                                  Container(
                                    child:Text('1 March , 2020'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: (){
                                    customDailog(context,
                                      ourData.data['image'],
                                      ourData.data['title'],
                                      ourData.data['paragraph']
                                        );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    margin: EdgeInsets.only(right: 15.0,bottom: 10.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFea9085),
                                      borderRadius: BorderRadius.circular(10.0)
                                    ),
                                    child: Text('Read More',
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
              },
            ),
          );
        }
      }
    ),
    );
  }
  customDailog(BuildContext context,String image,String title,String paragraph){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Container(
            height: MediaQuery.of(context).size.height/1.6,
            width: MediaQuery.of(context).size.width/2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                  colors: [Color(0xFFffb997),Color(0xFFffba92),Color(0xFFffb997),Color(0xFFffb997)],
              ),
            ),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 150,
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(image,width:MediaQuery.of(context).size.width,fit: BoxFit.cover),
                        ) ,
                      ),
                      Container(
                        child: InkWell(child: Icon(Icons.arrow_back,color: Colors.white),onTap: ()=>{Navigator.of(context).pop()},),
                      )
                    ],
                  ),
                  SizedBox(height: 5.0,),
                      SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text(title,
                                  style: TextStyle(
                                     fontSize: 25.0,
                                     fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10.0),
                                child: Text(paragraph,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                ],
              ),
          ),
        );
      }
    );
  }
}
