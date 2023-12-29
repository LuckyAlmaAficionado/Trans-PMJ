import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trans/app/constant/constant.dart';
import 'package:trans/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';
import '../widgets/icon_tile.dart';
import '../widgets/navbar.dart';
import '../widgets/subtitle.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.onBackButton != 1) {
          Constant.willPopScope(context);
          controller.onBackButton++;
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavBarHome(),
            ImageDashboard(),
            SubTitleMenu(controller: controller),
            const Gap(10),
            MainMenuDashboard(controller: controller),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}

class MainMenuDashboard extends StatelessWidget {
  const MainMenuDashboard({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          IconTileHome(
            onTap: () => controller.checkStatusUser(),
            text: 'perjalanan\nwisata',
            images: 'journey_icon.png',
          ),
          IconTileHome(
            onTap: () => Get.toNamed(Routes.HISTORY_TRIP),
            text: 'riwayat\nperjalanan',
            images: 'history.png',
          ),
          IconTileHome(
            onTap: () => Get.toNamed(Routes.PROFILE_PAGE),
            text: 'edit\nprofile',
            images: 'profile_icon.png',
          ),
          IconTileHome(
            onTap: () => controller.logout(),
            text: 'logout\naplikasi',
            images: 'switch.png',
          ),
        ],
      ),
    );
  }
}

class ImageDashboard extends StatelessWidget {
  const ImageDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          'https://knkt.go.id/api/apiimagestream/getimage_berita?x=00c824d4-f7c0-4695-99f2-25b8eeba89d3&x_Type=png&x_Kategori=Kegiatan',
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;

            print(loadingProgress);
            return Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: Get.width,
                height: 200,
                color: Colors.grey,
              ),
            );
          },
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class DataNotFound extends StatelessWidget {
  const DataNotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.web_asset_off_rounded,
            color: Colors.grey,
            size: 100,
          ),
          Text(
            "Tidak ada\nriwayat perjalanan".toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryTile extends StatelessWidget {
  const HistoryTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: Get.width,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQefNC1FLUFLWGi_J1iEP0IE04ZjSqH3PAx2SZ1YyfPpA&s',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama armada digunakan',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Tanggal: ${DateFormat('d-MM-yyyy').format(DateTime.now())}",
                  style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
