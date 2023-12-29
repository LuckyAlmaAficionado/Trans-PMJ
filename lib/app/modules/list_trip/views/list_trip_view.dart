import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trans/app/constant/colors.dart';
import 'package:trans/app/modules/list_trip/pariwisata_model.dart';
import 'package:trans/app/routes/app_pages.dart';

import '../controllers/list_trip_controller.dart';

class ListTripView extends GetView<ListTripController> {
  const ListTripView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getDataPariwisata;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 247, 254),
      body: Column(
        children: [
          _NavBarListTripView(),
          Expanded(
            child: Obx(() => (controller.listPariwisata.length == 0)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_off_outlined,
                        color: Colors.grey,
                        size: 150,
                      ),
                      const Gap(20),
                      Text(
                        "Tidak Ada Perjalanan",
                        style: GoogleFonts.outfit(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: controller.listPariwisata.length,
                    itemBuilder: (context, index) {
                      Pariwisata pariwisata = controller.listPariwisata[index];
                      return ListTileDetailInfromasiPariwisata(
                          controller: controller, pariwisata: pariwisata);
                    },
                  )),
          )
        ],
      ),
    );
  }
}

class ListTileDetailInfromasiPariwisata extends StatelessWidget {
  const ListTileDetailInfromasiPariwisata({
    super.key,
    required this.controller,
    required this.pariwisata,
  });

  final ListTripController controller;
  final Pariwisata pariwisata;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(Routes.ACCEPT_TRIP, arguments: pariwisata.idTripUtama),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.logo_dev,
                  color: Colors.grey,
                ),
                const Gap(5),
                Text(
                  pariwisata.namaBus!,
                  style: GoogleFonts.outfit(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${pariwisata.tanggalBerangkat} - ${pariwisata.waktuBerangkat!}",
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  controller.formatRupiah(int.parse(pariwisata.nilaiKontrak!)),
                  style: GoogleFonts.outfit(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Gap(5),
            Text(
              "${pariwisata.tanggalKembali} - ${pariwisata.waktuKembali!}",
              style: GoogleFonts.outfit(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const Gap(10),
            Text(
              'Tujuan Pariwisata: ',
              style: GoogleFonts.outfit(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              pariwisata.tujuanWisata!,
              style: GoogleFonts.outfit(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarListTripView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: primaryColor,
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: Row(
          children: [
            Text(
              'List Page',
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

// ignore: unused_element
class _ListTileListView extends StatelessWidget {
  const _ListTileListView({
    required this.namaBus,
    required this.tujuanBus,
    required this.nilaiKontrak,
    required this.onTap,
  });

  final String namaBus;
  final String tujuanBus;
  final int nilaiKontrak;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.green.shade300,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Armada: $namaBus',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Text(
              'Tujuan Armada: $tujuanBus',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Text(
              'Nilai Kontrak: $nilaiKontrak',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Text(
              'Waktu Berangkat: ${DateFormat('yMd').format(DateTime.now())}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
