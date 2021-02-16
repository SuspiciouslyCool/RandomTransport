import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:randomtransport/utils/types/station.dart';

class LookupService {
  final String baseURL = "https://transport.opendata.ch/v1";
  final Duration timeoutDuration = Duration(seconds: 5);

  Future<Station> getStartingStationData(String name) async {
    Response res;
    try {
      res = await get("$baseURL/stationboard?station=$name&limit=10").timeout(timeoutDuration);
      print(res.statusCode);
    
    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      Station station = Station.fromStationLookup(body["station"]);
      return station;
    } else {
      throw "An Error has occured.";
    }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Station>> getJourneyData(Station startingStation) async {
    Response res;
    try {
      res = await get("$baseURL/stationboard?id=${startingStation.id}&limit=10").timeout(timeoutDuration);
      print(res.statusCode);
    
    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      List<dynamic> connections =body["stationboard"];
      Random random = Random();

      Map<String, dynamic> connection = connections[random.nextInt(connections.length)];
      List<dynamic> passList = connection["passList"];
      
      List<Station> journey = List<Station>();

      for (Map<String, dynamic> entry in passList) {
        journey.add(Station.fromJourneyLookup(entry));
      }
      journey.removeAt(0);
      return journey;

      // print(stationBoard.journeys);
    } else {
      throw "An Error has occured.";
    }
    } catch (e) {
      print(e);
      return null;
    }
  }
}