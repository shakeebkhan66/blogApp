import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'PostDetailsPage.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home>{

  // When you listen on a Stream using Stream.listen, a StreamSubscription object is returned.
  // The subscription provides events to the listener,
  // and holds the callbacks used to handle the events.
  // The subscription can also be used to unsubscribe from the events,
  //or to temporarily pause the events from the stream.

  // ignore: cancel_subscriptions
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("BlogPost");

  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((dataSnapshot) {
      setState(() {
        snapshot=dataSnapshot.docs;
      });
    });
  }

  passData(DocumentSnapshot snap){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostDetails(snapshot: snap,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: ContinuousRectangleBorder(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(90.0),
              bottomRight: Radius.circular(120.0)
          ),),
        title: Text("BLOG APP", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.amber,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: ()=>debugPrint("Search")
          ),
          IconButton(
              icon: Icon(Icons.add),
              color: Colors.white,
              onPressed: ()=>debugPrint("Add")
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Shakeeb Ahmed Khan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              accountEmail: Text("abc@gmail.com", style: TextStyle(fontSize: 16,),),
              decoration: BoxDecoration(
                color: Colors.amber
              ),
            ),
            // ListTile widget is used to populate a ListView in Flutter.
            // It contains title as well as leading or trailing icons.

            ListTile(
              title: Text("First Page", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              leading: Icon(Icons.cake, color: Colors.amber,),
            ),
            ListTile(
              title: Text("Second Page", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              leading: Icon(Icons.search, color: Colors.orange,),
            ),
            ListTile(
              title: Text("Third Page", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              leading: Icon(Icons.cached, color: Colors.blue,),
            ),
            ListTile(
              title: Text("Fourth Page", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              leading: Icon(Icons.menu, color: Colors.deepPurpleAccent,),
            ),
            Divider(
              height: 20.0,
              color: Colors.amber,
            ),
            ListTile(
              title: Text("Close", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              trailing: Icon(Icons.close, color: Colors.red,),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),

      // ListView. builder is a way of constructing the list where children's (Widgets) are built on demand.
      // However, instead of returning a static widget,
      // it calls a function which can be called multiple times (based on itemCount )
      // and it's possible to return different widget at each call

      body: ListView.builder(
        itemCount: snapshot.length,
        itemBuilder: (context, index){
          return Card(
            elevation: 10.0,
            margin: EdgeInsets.all(10),
            child: Container(
             padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    child: Text(snapshot[index].data()['title'][0]),
                    backgroundColor: Colors.amber,
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    width: 210.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          child:    Text(snapshot[index].data()['title'],
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                          onTap: (){
                            passData(snapshot[index]);
                          },
                        ),

                        SizedBox(height: 5.0),
                        Text(snapshot[index].data()['content'],
                        maxLines: 2,
                        ),
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