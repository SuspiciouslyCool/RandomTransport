import 'package:flutter/material.dart';
import 'package:randomtransport/utils/theme.dart';

class JourneyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Themes.primaryColour,
        leading: Icon(Icons.chevron_left),
        title: Text("CURRENT STATION NAME"),
      ),
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView(

          );
        },
      ),
    );
  }
}