import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
class NewsScreen extends StatelessWidget {
  const NewsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgGrey,
        elevation: 0,
        title: Text("News"),


      ),
      body: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('news/new1/title').snapshots(),
            builder: (ctx,streamSnapshot){
              if(streamSnapshot.connectionState==ConnectionState.waiting)
              {return Center(child: CircularProgressIndicator(),);}
              final documents = streamSnapshot.data.documents;
              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (ctx,index)=>Text(documents[index]['title']));
            },
          )
      ),
    );
  }
}
