import 'package:flutter/material.dart';
import 'package:randomtransport/utils/theme.dart';

final stationErrorBar = SnackBar(
  content: Text("Could not get Station. Check your spelling or internet connection.", style: TextStyle(color: Themes.textColour),),
  backgroundColor: Themes.secondaryColour,
  duration: Duration(seconds: 2),
);

final connectionErrorBar = SnackBar(
  content: Text("Could not get Connection. Check your internet connection.", style: TextStyle(color: Themes.textColour),),
  backgroundColor: Themes.secondaryColour,
  duration: Duration(seconds: 2),
);