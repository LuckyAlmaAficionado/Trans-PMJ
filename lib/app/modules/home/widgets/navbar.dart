import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NavBarHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: Colors.green.shade500,
      padding: const EdgeInsets.all(15),
      child: SafeArea(
        child: Row(
          children: [
            Text(
              'Home Page',
              style: GoogleFonts.lato(
                fontSize: 19,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
