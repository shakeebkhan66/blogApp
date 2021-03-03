import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostDetails extends StatefulWidget{

  DocumentSnapshot snapshot;
  PostDetails({this.snapshot});

  @override
  _PostDetailsState createState() => _PostDetailsState();
}
class _PostDetailsState extends State<PostDetails>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POST DETAILS"),
        backgroundColor: Colors.amber,
      ),
      body: Card(
      elevation: 10.0,
      margin: EdgeInsets.all(10.0),
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                  child: Text(widget.snapshot.data()['title'][0]),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                SizedBox(width: 10.0),
                Text(
                  widget.snapshot.data()['title'],
                  style: TextStyle(fontSize: 22.0, color: Colors.green),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text(
              widget.snapshot.data()['content'],
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
      ));
  }
}