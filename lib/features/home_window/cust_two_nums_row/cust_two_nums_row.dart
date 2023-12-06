import 'package:flutter/material.dart';
import '../cust_input_field/index.dart';

class CustomTwoNumsRow extends StatefulWidget {
  final int initValue;
  final int maxValueFirst;
  final int maxValueSecond;
  final void Function(int) onChange;

  const CustomTwoNumsRow(
      {super.key,
      required this.initValue,
      required this.maxValueFirst,
      required this.maxValueSecond,
      required this.onChange});

  @override
  State<CustomTwoNumsRow> createState() => _CustomTwoNumsRowState();
}

class _CustomTwoNumsRowState extends State<CustomTwoNumsRow> {
  late int _currentValue;
  late int _currentValueFirstBox;
  late int _currentValueSecondBox;
  late int _maxValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initValue;
    _currentValueFirstBox = widget.initValue ~/ 60;
    _currentValueSecondBox = widget.initValue % 60;
    _maxValue = widget.maxValueFirst * 60 + widget.maxValueSecond;
  }

  void _incrementValue() {
    setState(() {
      if (_currentValue < _maxValue - 1) {
        _currentValue++;
      } else {
        _currentValue = 0;
      }
      _currentValueFirstBox = _currentValue ~/ 60;
      _currentValueSecondBox = _currentValue % 60;
      widget.onChange(_currentValue);
    });
  }

  void _decrementValue() {
    setState(() {
      if (_currentValue > 0) {
        _currentValue--;
      } else {
        _currentValue = _maxValue - 1;
      }
      _currentValueFirstBox = _currentValue ~/ 60;
      _currentValueSecondBox = _currentValue % 60;
      widget.onChange(_currentValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(
                Icons.remove,
                size: 40,
              ),
              onPressed: () {
                _decrementValue();
              },
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
        SizedBox(width: 8,),
        CustomInputField(
          initValue: _currentValueFirstBox,
          maxValue: widget.maxValueFirst,
          counterText: 'min',
          onInput: (newValue) {
            setState(() {
              _currentValue -= _currentValueFirstBox * 60;
              _currentValue += (newValue * 60);
              _currentValueFirstBox = newValue;
              widget.onChange(_currentValue);
            });
          },
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              ':',
              style: TextStyle(
                fontSize: 64,
              ),
            ),
            SizedBox(height: 24,),
          ],
        ),
        CustomInputField(
          initValue: _currentValueSecondBox,
          maxValue: widget.maxValueSecond.toInt(),
          counterText: 'sec',
          onInput: (newValue) {
            setState(() {
              _currentValue -= _currentValueSecondBox;
              _currentValue += newValue;
              if (_currentValue > _maxValue) {
                _currentValue -= _maxValue;
              }
              _currentValueFirstBox = _currentValue ~/ 60;
              _currentValueSecondBox = _currentValue % 60;

              widget.onChange(_currentValue);
            });
          },
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(
                Icons.add,
                size: 40,
              ),
              onPressed: () {
                _incrementValue();
              },
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ],
    );
  }
}
