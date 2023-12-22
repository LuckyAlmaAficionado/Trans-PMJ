import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_history_controller.dart';

class DetailHistoryView extends GetView<DetailHistoryController> {
  const DetailHistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NavBarDetailPerjalanan(),
        Container(
          width: Get.width,
          height: Get.height * 0.3,
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
          child: Image.network(
            'https://dummyimage.com/hd1080',
            fit: BoxFit.fill,
          ),
        ),
        const Gap(15),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Usaha Jaya Pustaka',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 19,
                            ),
                          ),
                          Text(
                            'H 1925 SX',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Colors.red,
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.favorite_outline,
                            size: 15,
                            color: Colors.red,
                          ),
                          color: Colors.grey,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Divider(thickness: 2),
                ),
                TileHistoryView(
                  title: 'Tanggal Keberangkatan',
                  subTitle:
                      "${DateFormat('d/MM/yyyy').format(DateTime.now())} - 10:20",
                  image: 'schedule_icon.png',
                ),
                TileHistoryView(
                  title: 'Tanggal Kepulangan',
                  subTitle:
                      "${DateFormat('d/MM/yyyy').format(DateTime.now().add(const Duration(days: 10)))} - 10:20",
                  image: 'schedule_icon.png',
                ),
                TileHistoryView(
                  title: 'Tujuan Wisata',
                  subTitle:
                      "Jl. puncak Mangu No.1, Batunya, Buleleng, Kabupaten Tabanan, Bali 82191",
                  image: 'map_icon.png',
                ),
                TileHistoryView(
                  title: 'Note',
                  subTitle:
                      "Lokasi penjemputan dilakukan didepan sman 2 Semarang di taman merdeka indah",
                  image: "notes_icon.png",
                ),
                TileHistoryView(
                  title: 'Pemasukan',
                  subTitle: "IDR 12.000.000",
                  image: "salary_icon.png",
                ),
                TileHistoryView(
                  title: 'Pengeluaran',
                  subTitle: "IDR 3.000.000",
                  image: "spending_icon.png",
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class TileHistoryView extends StatelessWidget {
  const TileHistoryView({
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
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            subTitle,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Divider(thickness: 2),
        ),
      ],
    );
  }
}

class NavBarDetailPerjalanan extends StatelessWidget {
  const NavBarDetailPerjalanan({
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
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            const Gap(10),
            Text(
              'Detail Perjalanan Pariwisata',
              style: GoogleFonts.poppins(
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
