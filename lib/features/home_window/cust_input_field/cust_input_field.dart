import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatefulWidget {
  final int initValue;
  final int maxValue;
  final String? counterText;
  final void Function(int) onInput;

  const CustomInputField(
      {super.key,
      required this.initValue,
      required this.maxValue,
      this.counterText,
      required this.onInput});

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late int _inputValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: TextField(
        style: TextStyle(fontSize: 64, fontWeight: FontWeight.w500,),
        keyboardType: TextInputType.number,
        maxLength: widget.maxValue.toString().length,
        controller: TextEditingController(
          text: widget.initValue.toString().padLeft(2, '0'),
        ),
        textAlign: TextAlign.center,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 5.0),
            counterText: widget.counterText,
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent))),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textInputAction: TextInputAction.done,
        onSubmitted: (text) {
          setState(() {
            _inputValue = int.parse(text);
            widget.onInput(_inputValue);
          });
        },
      ),
    );
  }
}
