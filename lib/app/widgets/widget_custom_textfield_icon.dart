import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CTextField extends StatelessWidget {
  CTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obsecureText = false,
    this.textInputType = TextInputType.none,
    this.textInputAction = TextInputAction.next,
    this.icons = Icons.abc,
  });

  final TextEditingController controller;
  final String label;
  TextInputAction textInputAction;
  TextInputType textInputType;
  IconData icons;
  bool obsecureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          textInputAction: textInputAction,
          controller: controller,
          obscureText: obsecureText,
          keyboardType: textInputType,
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icons,
              color: Colors.black,
            ),
            label: Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 1, color: Colors.grey),
            ),
          ),
        ),
        const Gap(25),
      ],
    );
  }
}
