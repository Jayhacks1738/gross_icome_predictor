import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscure;


  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscure,


  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.phone,
      controller: controller,
      decoration:  InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),

        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
        ),

        fillColor: Colors.grey[100],
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color:  Colors.grey[500]),

      ),
    );
  }
}