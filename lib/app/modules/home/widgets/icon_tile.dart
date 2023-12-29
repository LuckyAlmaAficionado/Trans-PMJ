import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trans/app/constant/colors.dart';

class IconTileHome extends StatelessWidget {
  const IconTileHome({
    required this.onTap,
    required this.text,
    required this.images,
  });

  final Function() onTap;
  final String text;
  final String images;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryContainerColor,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 2),
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 2,
                    )
                  ]),
              child: Image.asset(
                'assets/images/$images',
                height: 60,
              ),
            ),
            const Gap(8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(),
            )
          ],
        ),
      ),
    );
  }
}
