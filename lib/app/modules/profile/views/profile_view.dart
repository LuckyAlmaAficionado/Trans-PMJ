import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trans/app/constant/colors.dart';
import 'package:trans/app/modules/login/views/login_view.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getDataDiri();
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: Get.width,
              color: primaryColor,
              padding: const EdgeInsets.all(15),
              child: SafeArea(
                child: Row(
                  children: [
                    Text(
                      'Edit Profile',
                      style: GoogleFonts.outfit(
                        fontSize: 19,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(20),
            CircleAvatar(
              radius: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'username',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  const Gap(5),
                  Obx(
                    () => CustomTextFieldProfile(
                      controller: controller.usernameC,
                      hintText: controller.username.value,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    'nama lengkap',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  const Gap(5),
                  Obx(
                    () => CustomTextFieldProfile(
                      controller: controller.namaLengkapC,
                      hintText: controller.namaLengkap.value,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    'email',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  const Gap(5),
                  Obx(
                    () => CustomTextFieldProfile(
                      controller: controller.emailC,
                      hintText: controller.email.value,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    'no telpon',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  const Gap(5),
                  Obx(
                    () => CustomTextFieldProfile(
                      controller: controller.noTelponC,
                      hintText: controller.noTelpon.value,
                      textInputType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    'alamat',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  const Gap(5),
                  Obx(
                    () => CustomTextFieldProfile(
                      controller: controller.alamatC,
                      hintText: controller.alamat.value,
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const Gap(20),
                  CButton(
                    text: 'simpan',
                    onTap: () => controller.updateDataDiri(
                      controller.usernameC.text,
                      controller.namaLengkapC.text,
                      controller.emailC.text,
                      controller.noTelponC.text,
                      controller.alamatC.text,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextFieldProfile extends StatelessWidget {
  const CustomTextFieldProfile({
    super.key,
    required this.controller,
    required this.hintText,
    required this.textInputType,
    required this.textInputAction,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      textInputAction: textInputAction,
      controller: controller,
      style: GoogleFonts.outfit(),
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
      ),
    );
  }
}
