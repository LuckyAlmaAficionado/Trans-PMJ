import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Constant {
  static String API_KEY = "AIzaSyD7wkDZRk7DNF4ejfrm_RwW_Aaj6YOVoy8";

  static String SIGNUP_URL =
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$API_KEY";

  static String SIGNIN_URL =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$API_KEY";

  static String REALTIME_DATABASE =
      "https://backend-wisata-default-rtdb.asia-southeast1.firebasedatabase.app/";

  static dialog(String title, String subTitle, bool isSuccess) {
    Get.defaultDialog(
      title: title,
      titleStyle: GoogleFonts.outfit(
        color: (isSuccess) ? Colors.green : Colors.red,
        fontWeight: FontWeight.w600,
      ),
      content: Text(
        subTitle,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(),
      ),
    );
  }

  static String formatRupiah(int amount) {
    final formatCurrency =
        new NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ');
    return formatCurrency.format(amount);
  }

  static willPopScope(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: Text(
            'Press again to return.',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  static showAlertDialog(BuildContext context, String title, String text) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          title,
          style: GoogleFonts.outfit(),
        ),
        content: Text(
          text,
          style: GoogleFonts.outfit(),
        ),
      ),
    );
  }

  static snackbar(String title, String message, bool isSuccess) {
    Get.snackbar(
      title,
      message,
      margin: const EdgeInsets.all(20),
      snackPosition: SnackPosition.TOP,
      backgroundColor: (isSuccess)
          ? Color.fromARGB(255, 45, 106, 79)
          : Color.fromARGB(255, 199, 44, 65),
      titleText: Text(
        title,
        style: GoogleFonts.outfit(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      messageText: Text(
        message,
        style: GoogleFonts.outfit(
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
