import 'package:flutter/material.dart';
import 'package:randomtransport/utils/theme.dart';
import 'package:randomtransport/utils/types/types.dart';

class SliderInput extends StatefulWidget {
  final String label;
   final SliderInputCallback callback;
  SliderInput({this.label,this.callback});
  @override
  _SliderInputState createState() => _SliderInputState(label, callback);
}

class _SliderInputState extends State<SliderInput> {
  final String label;
  final SliderInputCallback callback;
  _SliderInputState(this.label, this.callback);

  double _currentSliderValue;

  @override
  void initState() {
    super.initState();
    _currentSliderValue=1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,style: TextStyle(
          color: Themes.textColour,
          fontSize: 18,
        ),textAlign: TextAlign.start,),
        Slider(
          divisions: 21,
          activeColor: Themes.primaryColour,
          inactiveColor: Themes.fillColour,
          min: 1,
          max: 22,
          label: _currentSliderValue.toInt().toString(),
          value: _currentSliderValue,
          onChanged: (double value) {
            setState(() {
              _currentSliderValue=value;
            });
            callback(_currentSliderValue.toInt());
          },
        ),
      ],
    );
  }
}