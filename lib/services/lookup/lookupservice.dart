import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:randomtransport/utils/types/connection.dart';
import 'package:randomtransport/utils/types/station.dart';

class LookupService {
  final String baseURL = "https://transport.opendata.ch/v1";
  final Duration timeoutDuration = Duration(seconds: 5);

  Future<Station> getStartingStationData(String name) async {
    Response res;
    try {
      res = await get("$baseURL/locations?query=$name")
          .timeout(timeoutDuration);
      print(res.statusCode);

      if (res.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(res.body);
        Station station = Station.fromStationLookup(body["stations"][0]);
        return station;
      } else {
        throw "An Error has occured.";
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Connection> getJourneyData(Station startingStation) async {
    Response res;
    try {
      res = await get("$baseURL/stationboard?id=${startingStation.id}&limit=10")
          .timeout(timeoutDuration);
      print(res.statusCode);

      if (res.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(res.body);
        List<dynamic> connections = body["stationboard"];
        Random random = Random();

        Map<String, dynamic> connection =
            connections[random.nextInt(connections.length)];
        print("passed");
        List<dynamic> passList = connection["passList"];

        List<Station> journey = List<Station>();

        for (Map<String, dynamic> entry in passList) {
          journey.add(Station.fromJourneyLookup(entry));
        }
        journey.removeAt(0);

        if (journey.length > 1) {
          int rand = random.nextInt(journey.length);
          if (rand == 0) {
            rand = 1;
          }
          journey = journey.sublist(0, rand);
        }
        return Connection(
          journey: journey,
          number: connection["number"],
          op: connection["operator"],
          platform: connection["stop"]["platform"],
          type: connection["category"],
        );
      } else {
        throw "An Error has occured.";
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
