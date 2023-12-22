import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Colors.green.shade100,
              Colors.green.shade300,
              Colors.green.shade500,
              Colors.green.shade700,
              Colors.green.shade900,
            ],
          ),
        ),
        child: Center(
          child: Container(
            width: Get.width,
            height: Get.height * 0.7,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  margin: const EdgeInsets.symmetric(
                    vertical: 100,
                    horizontal: 30,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(40),
                      Text(
                        "LOGIN",
                        style: GoogleFonts.outfit(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(20),
                      CustomTextFiedlLogin(
                        controller: controller.email,
                        label: 'Email',
                        icons: Icons.email_outlined,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.emailAddress,
                        obscureText: false,
                      ),
                      const Gap(20),
                      CustomTextFiedlLogin(
                        controller: controller.password,
                        label: 'Password',
                        icons: Icons.lock_outline_rounded,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.multiline,
                        obscureText: true,
                      ),
                      const Gap(25),
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green[900],
                        child: InkWell(
                          onTap: () => controller.signIn(
                              controller.email.text, controller.password.text),
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Center(
                              child: Text(
                                'LOGIN',
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 45,
                  left: 135,
                  right: 135,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/login_icon.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFiedlLogin extends StatelessWidget {
  const CustomTextFiedlLogin({
    super.key,
    required this.controller,
    required this.label,
    required this.icons,
    required this.textInputAction,
    required this.textInputType,
    required this.obscureText,
  });

  final String label;
  final TextEditingController controller;
  final IconData icons;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      obscureText: obscureText,
      style: GoogleFonts.outfit(),
      decoration: InputDecoration(
        labelStyle: GoogleFonts.outfit(fontSize: 16),
        label: Text(label),
        prefixIcon: Icon(icons),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 7,
        ),
      ),
    );
  }
}

class CButton extends StatelessWidget {
  const CButton({
    super.key,
    required this.text,
    this.onTap,
  });

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      color: Colors.green,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              text.toUpperCase(),
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
