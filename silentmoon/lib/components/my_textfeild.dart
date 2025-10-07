import 'package:flutter/material.dart';
import 'package:silentmoon/app/configs/theme.dart';

class MyTextfeild extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextfeild({
    super.key, 
    required this.controller, 
    required this.hintText, 
    required this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              color: ThemeConfigs.color2,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              color: ThemeConfigs.color12,
            ),
          ),
          fillColor: ThemeConfigs.color13,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: ThemeConfigs.color6,
            fontSize: 14,
          )
        ),
      ),
    );
  }
}