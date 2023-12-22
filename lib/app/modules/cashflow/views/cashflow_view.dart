import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/custom_button.dart';
import '../controllers/cashflow_controller.dart';

class CashflowView extends GetView<CashflowController> {
  const CashflowView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          width: Get.width,
          color: Colors.green,
          padding: const EdgeInsets.all(15),
          child: SafeArea(
            child: Row(
              children: [
                Text(
                  (Get.arguments == 1)
                      ? 'Pengeluaran bensin'
                      : 'Pengeluaran lainnya',
                  style: GoogleFonts.poppins(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
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
                    onTap: () => controller.pickImageFrom(ImageSource.camera),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.green,
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
                            'Foto bukti pengeluaran',
                            style: GoogleFonts.poppins(
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
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),
                  TextField(
                    controller: controller.nominalC,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Masukan nominal pembelian',
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const Gap(15),
                  (Get.arguments["id"] != 1)
                      ? Column(
                          children: [
                            TextField(
                              controller: controller.tujuanPengeluaranC,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Tujuan pengeluaran',
                                hintStyle: GoogleFonts.poppins(
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            const Gap(15),
                          ],
                        )
                      : SizedBox(),
                  TextField(
                    controller: controller.locationC,
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Masukan alamat pembelian',
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.grey,
                      ),
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
                      if (Get.arguments['id'] == 1) {
                        controller.sendDataPengeluaranBensin(
                          Get.arguments['idTrip'],
                          "Bensin",
                          controller.nominalC.text,
                          controller.locationC.text,
                        );
                      } else {
                        print('masuk sini');
                        controller.sendDataPengeluaranBensin(
                          Get.arguments['idTrip'],
                          controller.tujuanPengeluaranC.text,
                          controller.nominalC.text,
                          controller.locationC.text,
                        );
                      }
                    },
                    text: 'LANJUTKAN',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
