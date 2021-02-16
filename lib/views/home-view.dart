import 'package:flutter/material.dart';
import 'package:randomtransport/components/form/form.dart';
import 'package:randomtransport/utils/theme.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Themes.primaryColour,
          elevation: 0,
          title: Row(
            children: [
              Text(
                "RANDOM",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                "Transport",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        body: HomeForm());
  }
}
