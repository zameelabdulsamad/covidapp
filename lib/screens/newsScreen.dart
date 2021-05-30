import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidapp/statesList.dart';
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
          child:  new ListView.builder
      (
      itemCount: stateList.length,
          itemBuilder: (BuildContext context, int index) {
            return new Text(stateList[index].stateName);
          }
      )
      ),
    );
  }
}
