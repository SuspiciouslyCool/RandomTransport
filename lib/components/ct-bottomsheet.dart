import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomtransport/components/errorbar.dart';
import 'package:randomtransport/components/form/formbutton.dart';
import 'package:randomtransport/components/form/sliderinput.dart';
import 'package:randomtransport/services/lookup/lookupservice.dart';
import 'package:randomtransport/utils/types/changes.dart';
import 'package:randomtransport/utils/types/station.dart';
import 'package:randomtransport/views/journey-view.dart';

class ContinueTravelsBottomsheet extends StatefulWidget {
  final Station initialstartingStation;

  ContinueTravelsBottomsheet({this.initialstartingStation});
  @override
  _ContinueTravelsBottomsheetState createState() => _ContinueTravelsBottomsheetState();
}

class _ContinueTravelsBottomsheetState extends State<ContinueTravelsBottomsheet> {

  LookupService lookupService = LookupService();

  int _sliderInputValue;
  
  @override
  Widget build(BuildContext context) {
    Changes changes = Provider.of<Changes>(context);
    return Container(
      child: Column(
        children: [
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
                  if(_sliderInputValue==null || _sliderInputValue==0) {
                    return;
                  }
                  // Station startingStation = await lookupService.getStartingStationData(_textInputValue);
                  if(widget.initialstartingStation==null) {
                    ScaffoldMessenger.of(context).showSnackBar(stationErrorBar);
                    return;
                  }
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => JourneyView(
                      initialStartingStation: widget.initialstartingStation,
                    ),
                  ));
                  changes.setChanges(_sliderInputValue);
                },
              ),
        ],
      ),
    );
  }
}