import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trans/app/constant/constant.dart';
import 'package:trans/app/modules/list_trip/pariwisata_model.dart';
import 'package:trans/app/routes/app_pages.dart';

import '../controllers/history_trip_controller.dart';

class HistoryTripView extends GetView<HistoryTripController> {
  const HistoryTripView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        controller.startAnimation.value = false;
        await Future.delayed(Duration(milliseconds: 200));
        Get.back();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Riwayat Perjalanan',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Dibawah ini adalah riwayat perjalanan anda',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            titleSpacing: 0,
          ),
          body: Obx(() => ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                itemCount: controller.riwayatPerjalanan.length,
                itemBuilder: (context, index) {
                  Pariwisata data = controller.riwayatPerjalanan[index];
                  return Obx(() {
                    return ListTileHistoryPariwisata(
                      startAnimation: controller.startAnimation.value,
                      index: index,
                      pariwisata: data,
                    );
                  });
                },
              ))),
    );
  }
}

class NavBarHistoryTrip extends StatelessWidget {
  const NavBarHistoryTrip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Riwayat Perjalanan',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            const Gap(5),
            Text(
              'Dibawah ini adalah riwayat perjalanan anda',
              style: GoogleFonts.montserrat(
                color: Colors.grey.shade500,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListTileHistoryPariwisata extends StatelessWidget {
  ListTileHistoryPariwisata({
    super.key,
    required this.pariwisata,
    required this.index,
    required this.startAnimation,
  });

  final int index;
  final Pariwisata pariwisata;
  final bool startAnimation;

  @override
  Widget build(BuildContext context) {
    print(startAnimation);
    return AnimatedContainer(
      curve: Curves.easeInOutQuart,
      width: Get.width,
      duration: Duration(milliseconds: 300 + (index * 200)),
      transform:
          Matrix4.translationValues(startAnimation ? 0 : Get.width, 0, 0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: Get.width,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 5),
                spreadRadius: 5,
                blurRadius: 5,
                color: Colors.grey.shade200,
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trip #: ${pariwisata.idTripUtama!.split('-').last.toUpperCase()}',
              style: GoogleFonts.montserrat(
                fontSize: 17,
                color: Colors.indigoAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(10),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Berangkat',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      "${pariwisata.tanggalBerangkat} - ${pariwisata.waktuBerangkat}",
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(thickness: 2),
                )),
                Column(
                  children: [
                    Text(
                      'Kembali',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      "${pariwisata.tanggalKembali} - ${pariwisata.waktuKembali}",
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(20),
            Text(
              "${Constant.formatRupiah(int.parse(pariwisata.nilaiKontrak!))}",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.indigoAccent.shade200,
              ),
            ),
            const Gap(20),
            Material(
              borderRadius: BorderRadius.circular(15),
              color: Colors.indigoAccent.withOpacity(0.2),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () =>
                    Get.toNamed(Routes.DETAIL_HISTORY, arguments: pariwisata),
                splashColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Center(
                    child: Text(
                      'Details',
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigoAccent,
                      ),
                    ),
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
