import 'package:flutter/material.dart';
import '../cust_input_field/index.dart';

class CustomOneNumRow extends StatefulWidget {
  final int initValue;
  final int maxValue;
  final void Function(int) onChange;

  const CustomOneNumRow(
      {super.key,
      required this.initValue,
      required this.maxValue,
      required this.onChange});

  @override
  State<CustomOneNumRow> createState() => _CustomOneNumRowState();
}

class _CustomOneNumRowState extends State<CustomOneNumRow> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initValue;
  }

  void _incrementValue() {
    setState(() {
      if (_currentValue < widget.maxValue) {
        _currentValue++;
      } else {
        _currentValue = 0;
      }
      widget.onChange(_currentValue);
    });
  }

  void _decrementValue() {
    setState(() {
      if (_currentValue > 0) {
        _currentValue--;
      } else {
        _currentValue = widget.maxValue;
      }
      widget.onChange(_currentValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(height: 8,),
            IconButton(
              icon: const Icon(Icons.remove, size: 40,),
              onPressed: () {
                _decrementValue();
              },
            ),
          ],
        ),
        SizedBox(width: 8,),
        CustomInputField(
          initValue: _currentValue,
          maxValue: widget.maxValue,
          counterText: '',
          onInput: (newValue) {
            setState(() {
              _currentValue = newValue;
              widget.onChange(_currentValue);
            });
          },
        ),
        Column(
          children: [
            SizedBox(height: 8,),
            IconButton(
              icon: const Icon(Icons.add, size: 40,),
              onPressed: () {
                _incrementValue();
              },
            ),
          ],
        ),
      ],
    );
  }
}
