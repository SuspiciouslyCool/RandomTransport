import 'package:flutter/material.dart';
import 'package:randomtransport/utils/theme.dart';
import 'package:randomtransport/utils/types/station.dart';

import '../utils/types/stationtype.dart';

class TimeTableListEntry extends StatelessWidget {
  final Station station;
  final Color backgroundColour;
  TimeTableListEntry({this.station, this.backgroundColour});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      color: backgroundColour,
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              SizedBox(
                width: 25,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    height: double.infinity,
                    color: Themes.secondaryColour,
                    width: 5,
                  ),
                  station.type == StationType.END
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 25,
                            width: 5,
                            color: backgroundColour,
                          ),
                        )
                      : Container(),
                  station.type == StationType.START
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 25,
                            width: 5,
                            color: backgroundColour,
                          ),
                        )
                      : Container(),
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Themes.secondaryColour),
                  )
                ],
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${station.arrival}",
                    style: TextStyle(
                        color: Themes.textColour, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "${station.departure}",
                    style: TextStyle(
                        color: Themes.textColour, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              SizedBox(
                width: 25,
              ),
              Text(
                station.name != null ? station.name : station.id,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Themes.textColour,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
