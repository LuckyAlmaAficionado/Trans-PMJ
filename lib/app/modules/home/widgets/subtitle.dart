import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trans/app/constant/constant.dart';

import '../controllers/home_controller.dart';

class SubTitleMenu extends StatelessWidget {
  const SubTitleMenu({
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            'Menu utama',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          const Gap(10),
          Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: Colors.black),
            ),
            child: GestureDetector(
              onTap: () {
                Constant.showAlertDialog(
                  context,
                  "Menu Perjalanan",
                  "Pilihan menu sesuai dengan kebutuhan.",
                );
              },
              child: const Icon(
                Icons.question_mark,
                size: 8,
              ),
            ),
          )
        ],
      ),
    );
  }
}
