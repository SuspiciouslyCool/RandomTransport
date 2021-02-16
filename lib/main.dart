import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomtransport/utils/theme.dart';
import 'package:randomtransport/utils/types/changes.dart';
import 'package:randomtransport/views/home-view.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => Changes(),
    child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Themes.primaryColour,
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Poppins'),
      ),
      home: HomeView(),
    );
  }
}