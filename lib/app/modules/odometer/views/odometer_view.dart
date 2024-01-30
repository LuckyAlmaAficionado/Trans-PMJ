import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trans/app/constant/colors.dart';
import 'package:trans/app/routes/app_pages.dart';
import 'package:trans/app/widgets/custom_button.dart';

import '../controllers/odometer_controller.dart';

class OdometerView extends GetView<OdometerController> {
  const OdometerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.HOME);
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            NavBarOdometer(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            height: Get.height * 0.3,
                            width: Get.width,
                            child: (!controller.pathFile.value.isEmpty)
                                ? Image.file(File(controller.pathFile.value))
                                : Container(),
                          )),
                      GestureDetector(
                        onTap: () =>
                            controller.pickImageFrom(ImageSource.camera),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          height: Get.height * 0.08,
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                (!Get.arguments['isTrue'])
                                    ? 'Foto kilometer awal'
                                    : 'Foto kilometer akhir',
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Material(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                                child: Icon(
                                  Icons.add,
                                  color: primaryColor.withOpacity(0.4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(20),
                      TextField(
                        controller: controller.ordometerC,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.outfit(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.edit),
                          label: (!Get.arguments["isTrue"])
                              ? Text('Masukan kilometer awal')
                              : Text('Masukan kilometer akhir'),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const Gap(20),
                      CustomButton(
                        onTap: () {
                          print(Get.arguments['isTrue']);
                          print(Get.arguments['idTrip']);
                          (Get.arguments['isTrue'])
                              ? controller.akhiriPerjalananWisata(
                                  Get.arguments["idTrip"],
                                  controller.ordometerC.text,
                                )
                              : controller.mulaiTripPariwisata(
                                  Get.arguments["idTrip"],
                                  controller.ordometerC.text,
                                );
                        },
                        text: 'Lanjutkan',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavBarOdometer extends StatelessWidget {
  const NavBarOdometer({
    super.key,
  });

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
              'Ordometer',
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
