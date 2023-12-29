import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trans/app/constant/colors.dart';

class NavBarHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: primaryColor,
      padding: const EdgeInsets.all(15),
      child: SafeArea(
        child: Row(
          children: [
            Text(
              'Home Page',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 19,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
