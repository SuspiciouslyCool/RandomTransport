import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomtransport/components/timetablelistentry.dart';
import 'package:randomtransport/services/lookup/lookupservice.dart';
import 'package:randomtransport/utils/theme.dart';
import 'package:randomtransport/utils/types/changes.dart';
import 'package:randomtransport/utils/types/connection.dart';
import 'package:randomtransport/utils/types/station.dart';
import 'package:randomtransport/views/end-view.dart';

class JourneyView extends StatefulWidget {
  final Station initialStartingStation;

  JourneyView({this.initialStartingStation});
  @override
  _JourneyViewState createState() => _JourneyViewState();
}

class _JourneyViewState extends State<JourneyView> {
  // Future<List<Station>> connection.journey;
  Future<Connection> connection;
  List<Station> _journeyData;
  Connection _connectionData;
  LookupService lookupService = LookupService();
  Station _startingStation;

  @override
  void initState() {
    super.initState();
    _startingStation = widget.initialStartingStation;
    connection = lookupService.getJourneyData(_startingStation);
    // connection.journey = lookupService.getJourneyData(_startingStation);
  }

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
        title: Text(_startingStation.name),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          Changes changes = Provider.of<Changes>(context, listen: false);
          if(changes.changes==0) {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => EndView(
                lastStation: _startingStation,
                firstStation: widget.initialStartingStation,
              ),
            ));
          }
          changes.decrement();
          
          // _journeyData = await connection;
          _connectionData= await connection;
          
          setState(() {
            _startingStation=_connectionData.journey.last;
            connection=lookupService.getJourneyData(_startingStation);
          });
        },
              child: Container(
          color: Themes.primaryColour,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("NEXT STEP", style: TextStyle(color: Colors.white, fontSize: 24)),
              Icon(Icons.chevron_right, size: 36, color: Colors.white,)
            ],
          )
        ),
      ),
      body: FutureBuilder(
        future: connection,
        builder: (BuildContext context, AsyncSnapshot<Connection> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: new List.generate(
                  snapshot.data.journey.length,
                  (int index) => TimeTableListEntry(
                        station: snapshot.data.journey[index],
                        backgroundColour:
                            index % 2 == 0 ? Themes.fillColour : Colors.white,
                      )),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
