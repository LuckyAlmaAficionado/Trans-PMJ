import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trans/app/routes/app_pages.dart';

import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  const ProfilePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getDataDiri();
    return Scaffold(
        body: Column(
      children: [
        NavBarKelolaProfile(),
        const Gap(30),
        PhotoProfile(),
        const Gap(15),
        Obx(() => Text(
              controller.namaLengkap.value,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            )),
        Obx(() => Text(
              controller.email.value,
              style: GoogleFonts.outfit(
                fontSize: 15,
              ),
            )),
        const Gap(25),
        Obx(() => TentangSayaKelolaProfile(
              username: controller.username.value,
              namaLengkap: controller.namaLengkap.value,
              email: controller.email.value,
              noTelpon: controller.noTelpon.value,
              alamat: controller.alamat.value,
            )),
        const Gap(30),
      ],
    ));
  }
}

class TentangSayaKelolaProfile extends StatelessWidget {
  const TentangSayaKelolaProfile({
    super.key,
    required this.username,
    required this.namaLengkap,
    required this.email,
    required this.noTelpon,
    required this.alamat,
  });

  final String username;
  final String namaLengkap;
  final String email;
  final String noTelpon;
  final String alamat;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 2,
            color: Colors.grey.shade100,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tentang Saya',
                      style: GoogleFonts.outfit(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.PROFILE),
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.green,
                            size: 15,
                          ),
                          const Gap(2),
                          Text(
                            'UBAH',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ListTileProfile(
                text: 'Username',
                subText: username,
              ),
              ListTileProfile(
                text: 'Nama Lengkap',
                subText: namaLengkap,
              ),
              ListTileProfile(
                text: 'Email',
                subText: email,
              ),
              ListTileProfile(
                text: 'No Telpon',
                subText: noTelpon,
              ),
              ListTileProfile(
                text: 'Alamat',
                subText: alamat,
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}

class PhotoProfile extends StatelessWidget {
  const PhotoProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 60,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green[50],
              border: Border.all(
                width: 2,
                color: Colors.white,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.camera_alt_rounded,
                color: Colors.green,
                size: 17,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NavBarKelolaProfile extends StatelessWidget {
  const NavBarKelolaProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: Colors.green,
      padding: const EdgeInsets.all(15),
      child: SafeArea(
        child: Row(
          children: [
            Text(
              'Kelola Profil',
              style: GoogleFonts.outfit(
                fontSize: 19,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListTileProfile extends StatelessWidget {
  const ListTileProfile({
    super.key,
    required this.text,
    required this.subText,
  });

  final String text;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          Text(
            text,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(10),
          Text(
            subText,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
