import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/material.dart';

import '../constants.dart';
final newsCollection = FirebaseFirestore.instance.collection("News");
class NewsScreen extends StatefulWidget {
  const NewsScreen({Key key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgGrey,
        elevation: 0,
        title: Text("News"),
      ),
      body:StreamBuilder(
        stream: FirebaseFirestore.instance.collection("News").snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
          return Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: snapshot.data.docs.map((document){
                  return Column(
                    children: [
                      Text(document['Heading']),
                      Text(document['q']),

                    ],
                  );

                }).toList(),
              )

            ],

          );
        },

      ),








    );
  }
}



