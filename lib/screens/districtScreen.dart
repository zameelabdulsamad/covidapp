import 'package:flutter/material.dart';

import '../constants.dart';
class DistrictScreen extends StatelessWidget {
  const DistrictScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgGrey,
        elevation: 0,
        title: Text("Malappuram"),

      ),
    );
  }
}
