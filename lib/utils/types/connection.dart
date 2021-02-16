import 'package:randomtransport/utils/types/station.dart';

class Connection {

  String platform;
  String number;
  String op;
  String type;

  List<Station> journey;

  Connection({this.platform, this.number, this.op, this.journey, this.type});
}