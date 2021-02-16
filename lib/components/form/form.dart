import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomtransport/components/errorbar.dart';
import 'package:randomtransport/components/form/formbutton.dart';
import 'package:randomtransport/components/form/sliderinput.dart';
import 'package:randomtransport/components/form/textinput.dart';
import 'package:randomtransport/services/lookup/lookupservice.dart';
import 'package:randomtransport/utils/types/changes.dart';
import 'package:randomtransport/utils/types/station.dart';
import 'package:randomtransport/views/journey-view.dart';

class HomeForm extends StatefulWidget {
  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {

  String _textInputValue;
  int _sliderInputValue;

  LookupService lookupService = LookupService();

  @override
  void initState() {
    super.initState();
    _textInputValue="";
    _sliderInputValue=1;
  }

  @override
  Widget build(BuildContext context) {
    Changes changes = Provider.of<Changes>(context);
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
                callback: () async {
                  if(_textInputValue==null || _textInputValue=="" || _sliderInputValue==null || _sliderInputValue==0) {
                    return;
                  }
                  Station startingStation = await lookupService.getStartingStationData(_textInputValue);
                  if(startingStation==null) {
                    ScaffoldMessenger.of(context).showSnackBar(stationErrorBar);
                    return;
                  }
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => JourneyView(
                      initialStartingStation: startingStation,
                    ),
                  ));
                  changes.setChanges(_sliderInputValue);
                },
              ),
            ],
          ),
        ),
      );
  }
}