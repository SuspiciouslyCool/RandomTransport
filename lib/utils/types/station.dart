import 'package:randomtransport/utils/types/stationtype.dart';

class Station {
  String name;
  String id;
  String arrival;
  String departure;
  StationType type;

  Station({this.name, this.id, this.arrival, this.departure, this.type});

  Station.fromStationLookup(Map<String, dynamic> json) {
    name=json["name"];
    id=json["id"];
  }

  Station.fromJourneyLookup(Map<String, dynamic> json) {
    name=json["station"]["name"];
    id=json["station"]["id"];

    if(json["arrivalTimestamp"]!=null) {
      DateTime arrivalTimestamp=DateTime.fromMillisecondsSinceEpoch(json["arrivalTimestamp"]*1000);
      arrival="${arrivalTimestamp.hour}:${arrivalTimestamp.minute}";
    } else {
      arrival="";
    }

    if(json["departureTimestamp"]!=null) {
      DateTime departureTimestamp=DateTime.fromMillisecondsSinceEpoch(json["departureTimestamp"]*1000);
      departure="${departureTimestamp.hour}:${departureTimestamp.minute}";
    } else {
      departure="";
    }

    type=StationType.NORMAL;
  }
}