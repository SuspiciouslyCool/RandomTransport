import 'package:flutter/material.dart';
import 'package:randomtransport/components/form/formbutton.dart';
import 'package:randomtransport/components/form/sliderinput.dart';
import 'package:randomtransport/components/form/textinput.dart';

class HomeForm extends StatefulWidget {
  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {

  String _textInputValue;
  int _sliderInputValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textInputValue="";
    _sliderInputValue=0;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              TextInput(
                label: "STARTING STATION",
                callback: (String text) {
                  setState(() {
                    _textInputValue=text;
                  });
                },
              ),
              SizedBox(
                height: 51,
              ),
              SliderInput(
                label: "NUMBER OF CHANGES",
                callback: (int changes) {
                  setState(() {
                    _sliderInputValue=changes;
                  });
                },
              ),
              SizedBox(
                height: 51,
              ),
              FormButton(
                label: "GO!",
                callback: () {
                  //TODO: Get Station info from name;
                  //TODO: Global Variable for amount of stations left;
                },
              ),
            ],
          ),
        ),
      );
  }
}