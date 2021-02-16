import 'package:flutter/material.dart';
import 'package:randomtransport/utils/theme.dart';
import 'package:randomtransport/utils/types/types.dart';

class TextInput extends StatefulWidget {
  final String label;
  final TextInputCallback callback;
  const TextInput({this.label, this.callback});

  @override
  _TextInputState createState() => _TextInputState(this.label,this.callback);
}

class _TextInputState extends State<TextInput> {
  final String label;
  final TextInputCallback callback;
  _TextInputState(this.label, this.callback);
  
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text="";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,style: TextStyle(
          color: Themes.textColour,
          fontSize: 18,
        ),textAlign: TextAlign.start,),
        TextField(
          cursorColor: Themes.primaryColour,
          controller: _controller,
          onChanged: (String string) {
            callback(_controller.text);
          },
          decoration: InputDecoration(
            fillColor: Themes.fillColour,
            focusColor: Themes.fillColour,
            filled: true,
            contentPadding: EdgeInsets.all(10),
            isDense: true,
          ),
        ),
      ],
    );
  }
}