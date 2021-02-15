import 'package:flutter/material.dart';
import 'package:randomtransport/utils/theme.dart';
import 'package:randomtransport/utils/types.dart';

class FormButton extends StatelessWidget {
  final OnClickedCallback callback;
  final String label;

  FormButton({this.callback, this.label});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: callback,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        child: Text(label, style: TextStyle(color: Colors.white),),
      ),
      color: Themes.primaryColour,
    );
  }
}