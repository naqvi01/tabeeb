import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Forms extends StatelessWidget {
  final Text? label;
  final Icon? icon;

  final TextEditingController? controller;
  Forms({
    this.label,
    this.icon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Required to Fill';
          } else {
            return null;
          }
        },
        style:
            TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            label: label,
            prefixIcon: icon,
            floatingLabelStyle: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255), fontSize: 18),
            labelStyle: TextStyle(color: Color.fromARGB(255, 251, 251, 251))),
        controller: controller,
      ),
    );
  }
}
