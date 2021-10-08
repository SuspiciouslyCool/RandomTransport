import 'package:flutter/material.dart';
import 'package:randomtransport/components/ct-bottomsheet.dart';
import 'package:randomtransport/components/form/formbutton.dart';
import 'package:randomtransport/utils/theme.dart';
import 'package:randomtransport/utils/types/station.dart';

class EndView extends StatelessWidget {

  final Station firstStation;
  final Station lastStation;

  EndView({this.firstStation, this.lastStation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Themes.primaryColour,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.chevron_left)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "CONGRATS!",
                style: TextStyle(fontSize: 36, color: Themes.textColour),
              ),
              Text(
                "YOU HAVE SUCCESSFULLY WASTED YOUR TIME!",
                style: TextStyle(
                  fontSize: 18,
                  color: Themes.textColour,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 51,
              ),
              FormButton(
                label: "CONNECTIONS TO START",
                callback: () async {
                  
                },
              ),
              SizedBox(
                height: 25,
              ),
              FormButton(
                label: "CONTINUE TRAVELS",
                callback: () async {
                 showModalBottomSheet(
                   context: context,
                   builder: (BuildContext context) => ContinueTravelsBottomsheet(
                     initialstartingStation: lastStation,
                   ),
                 );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
