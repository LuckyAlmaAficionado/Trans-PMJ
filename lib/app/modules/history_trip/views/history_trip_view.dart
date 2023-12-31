import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trans/app/constant/colors.dart';
import 'package:trans/app/modules/list_trip/pariwisata_model.dart';
import 'package:trans/app/routes/app_pages.dart';

import '../controllers/history_trip_controller.dart';

class HistoryTripView extends GetView<HistoryTripController> {
  const HistoryTripView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        NavBarHistoryTrip(),
        Expanded(
          child: Obx(() => ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                itemCount: controller.riwayatPerjalanan.length,
                itemBuilder: (context, index) {
                  // print(controller.riwayatPerjalanan.length);
                  Pariwisata data = controller.riwayatPerjalanan[index];
                  // print(data.createdAt);
                  // print(data.namaBus);
                  return ListTileHistoryPariwisata(
                    pariwisata: data,
                  );
                },
              )),
        ),
      ],
    ));
  }
}

class NavBarHistoryTrip extends StatelessWidget {
  const NavBarHistoryTrip({
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
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            const Gap(10),
            Text(
              'History Pariwisata',
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

class ListTileHistoryPariwisata extends StatelessWidget {
  const ListTileHistoryPariwisata({
    super.key,
    required this.pariwisata,
  });

  final Pariwisata pariwisata;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.DETAIL_HISTORY, arguments: pariwisata),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 2),
              color: Colors.grey.shade300,
              spreadRadius: 5,
              blurRadius: 4,
            ),
          ],
          border: Border.all(
            width: 2,
            color: Colors.grey.shade100,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              height: Get.height * 0.2,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(6),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(6),
                  topLeft: Radius.circular(6),
                ),
                child: Image.network(
                  'https://dummyimage.com/hd1080',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pariwisata.namaBus!,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    pariwisata.tujuanWisata!,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        pariwisata.tanggalBerangkat!,
                        style: GoogleFonts.outfit(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        " - ${pariwisata.waktuBerangkat}",
                        style: GoogleFonts.outfit(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
