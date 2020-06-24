import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Itemthree extends StatefulWidget {
  @override
  _ItemthreeState createState() => _ItemthreeState();
}

class _ItemthreeState extends State<Itemthree> {
  Future getItemThree()async{
    var firestore=Firestore.instance;
    QuerySnapshot snap=await firestore.collection('GridData').getDocuments();
    return snap.documents;
  }
  Future<Null>getRefresh()async{
    await Future.delayed(Duration(seconds:3));
    setState(() {
      getItemThree();
    });
  }
  List<Color> _colorsItems=[Colors.white,Color(0xFFfbe555),Colors.black,Colors.black,Color(0xFFfbe555),Colors.white];
  Color color;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFea9085),
        title: Text('Blog App',
          style:TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold
          ) ,
        ),
      ),
      body: FutureBuilder(
        future: getItemThree(),
          builder:(context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else{
            return RefreshIndicator(
              onRefresh: getRefresh,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: snapshot.data.length,
                itemBuilder: (context,index){
                  var ourData=snapshot.data[index];
                  color=_colorsItems[index %_colorsItems.length];
                  return Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: InkWell(
                      onTap: (){
                        customDailog(context, ourData.data['image']);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height,
                              child: Image.network(ourData.data['image'],fit: BoxFit.cover),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(ourData.data['text'],
                                style:TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                  color: color
                                ) ,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
            }
          },
      ),
    );
  }
  customDailog(BuildContext context ,String img){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
            ),
            child: Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width/2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(img,fit: BoxFit.cover,),
              ),
            ),
          );
      }
    );
  }
}
