import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomtransport/components/errorbar.dart';
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
  Future<Connection> connection;
  Connection _connectionData;
  LookupService lookupService = LookupService();
  Station _startingStation;

  @override
  void initState() {
    super.initState();
    _startingStation = widget.initialStartingStation;
    connection = lookupService.getJourneyData(_startingStation);
  }

  void _onAfterBuild(BuildContext context) async {
    Connection _tmpConnection = await connection;
    setState(() {
      _connectionData = _tmpConnection;
    });
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
      bottomNavigationBar: Container(
        height: _connectionData != null ? 120 : 60,
        child: Column(
          children: [
            _connectionData != null
                ? Container(
                    color: Themes.primaryColour,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                            "${_connectionData.type}-${_connectionData.number}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        Text("${_connectionData.op}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        Text(
                            _connectionData.platform != null
                                ? _connectionData.platform
                                : "",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        SizedBox(
                          width: 25,
                        ),
                      ],
                    ))
                : Container(),
            GestureDetector(
              onTap: () async {
                _connectionData = await connection;

                if (_connectionData == null) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(connectionErrorBar);
                  return;
                }

                Changes changes = Provider.of<Changes>(context, listen: false);
                if (changes.changes == 0) {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => EndView(
                      lastStation: _startingStation,
                      firstStation: widget.initialStartingStation,
                    ),
                  ));
                }
                changes.decrement();

                setState(() {
                  _startingStation = _connectionData.journey.last;
                  connection = lookupService.getJourneyData(_startingStation);
                });
              },
              child: Container(
                  color: Themes.primaryColour,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("NEXT STEP",
                          style: TextStyle(color: Colors.white, fontSize: 24)),
                      Icon(
                        Icons.chevron_right,
                        size: 36,
                        color: Colors.white,
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: connection,
        builder: (BuildContext context, AsyncSnapshot<Connection> snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _onAfterBuild(context));
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
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Themes.secondaryColour
                )
              ),
            );
          }
        },
      ),
    );
  }
}
