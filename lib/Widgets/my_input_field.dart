// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyInputField extends StatefulWidget {
  final String labelText;
  final bool isPass;
  final double width;
  final double height;
  final String? Function(String?)? validator;

  final controller;
  final keyboardType;
  final autofillHints;
  final obscureText;
  MyInputField({
    Key? key,
    required this.labelText,
    // required this.suffixIcon,
    required this.autofillHints,
    required this.obscureText,
    required this.height,
    required this.width,
    required this.controller,
    required this.validator,
    required this.keyboardType,
    required this.isPass,
  }) : super(key: key);

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  bool _showPassword = false;
  void initState() {
    super.initState();
    if (widget.isPass) {
      _showPassword = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textInputAction: TextInputAction.next,
        autofillHints: widget.autofillHints,
        cursorColor: Colors.white,
        obscureText: _showPassword,
        style: TextStyle(color: Colors.white, fontSize: 18),
        decoration: InputDecoration(
          // border:
          //     OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[400]!,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(40.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(40.0),
          ),
          // enabledBorder:
          //     OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelStyle: TextStyle(color: Colors.white),
          labelText: widget.labelText,
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
