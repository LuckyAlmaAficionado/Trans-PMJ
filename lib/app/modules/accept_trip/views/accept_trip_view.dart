import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trans/app/constant/colors.dart';
import 'package:trans/app/constant/constant.dart';
import 'package:trans/app/modules/list_trip/controllers/list_trip_controller.dart';
import 'package:trans/app/modules/list_trip/pariwisata_model.dart';
import 'package:trans/app/widgets/custom_button.dart';

import '../controllers/accept_trip_controller.dart';

class AcceptTripView extends GetView<AcceptTripController> {
  const AcceptTripView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getDataPariwisata(Get.arguments);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NavBarAccTrip(),
          Container(
            height: Get.height * 0.27,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
            ),
            child: Center(
              child: Icon(
                Icons.image,
                size: 70,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const Gap(10),
          FutureBuilder(
            future: controller.getDataPariwisata(Get.arguments),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                    child: Center(child: CircularProgressIndicator()));
              } else {
                Pariwisata data = snapshot.data as Pariwisata;

                return Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        TileAcceptTrip(
                          title: 'Nama Armada',
                          subTitle: data.namaBus!,
                          image: 'bus_icon.png',
                        ),
                        TileAcceptTrip(
                          title: 'Plat Kendaraan',
                          subTitle: data.platBus!,
                          image: 'plat_nomor.png',
                        ),
                        TileAcceptTrip(
                          title: 'Tujuan Wisata',
                          subTitle: data.tujuanWisata!,
                          image: 'tujuan_icon.png',
                        ),
                        TileAcceptTrip(
                          title: 'Nilai Kontrak',
                          subTitle: Get.put(ListTripController())
                              .formatRupiah(int.parse(data.nilaiKontrak!)),
                          image: 'salary_icon.png',
                        ),
                        TileAcceptTrip(
                          title: 'Tanggal Keberangkatan',
                          subTitle:
                              '${data.tanggalBerangkat} - ${data.waktuBerangkat}',
                          image: 'arrival_icon.png',
                        ),
                        TileAcceptTrip(
                          title: 'Tanggal Kepulangan',
                          subTitle:
                              '${data.tanggalKembali} - ${data.waktuKembali}',
                          image: 'schedule_icon.png',
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: Get.height * 0.11,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomButton(
            onTap: () => controller.terimaPerjalanan(Get.arguments),
            text: 'Terima Perjalanan',
          ),
        ),
      ),
    );
  }
}

class NavBarAccTrip extends StatelessWidget {
  const NavBarAccTrip({
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Informasi keberangkatan',
              style: GoogleFonts.outfit(
                fontSize: 19,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {
                Constant.showAlertDialog(
                  context,
                  "Informasi Keberangkatan",
                  'Informasi mengenai armada dan tujuan sebelum memulai perjalan wisata',
                );
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                  ),
                ),
                child: Icon(
                  Icons.search,
                  size: 10,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TileAcceptTrip extends StatelessWidget {
  const TileAcceptTrip({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
  });

  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.shade200,
            ),
            child: Image.asset(
              'assets/images/${image}',
            ),
          ),
          title: Text(
            title,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            subTitle,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
        ),
        Divider(thickness: 2),
      ],
    );
  }
}
