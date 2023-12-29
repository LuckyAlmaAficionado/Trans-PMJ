// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trans/app/constant/constant.dart';
import 'package:trans/app/modules/list_trip/pariwisata_model.dart';
import 'package:trans/app/routes/app_pages.dart';

import '../controllers/trip_controller.dart';

class TripView extends GetView<TripController> {
  const TripView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.HOME);
        return false;
      },
      child: Scaffold(
        body: SlidingUpPanel(
          maxHeight: Get.height * 0.8,
          minHeight: Get.height * 0.6,
          backdropEnabled: true,
          color: Colors.transparent,
          panel: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: FutureBuilder(
              future: controller.getPariwisataByIdDetailPerjalanan(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: [CircularProgressIndicator()],
                  );
                } else if (snapshot.hasData) {
                  Pariwisata data = snapshot.data as Pariwisata;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.namaBus!,
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.search,
                                size: 15,
                              ),
                              color: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      Text(
                        data.platBus!,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                      Divider(thickness: 2),
                      TileTrip(
                        title: 'Tanggal keberangkatan',
                        subTitle:
                            "${data.tanggalBerangkat} - ${data.waktuBerangkat}",
                      ),
                      TileTrip(
                        title: 'Estimasi Tanggal kepulangan',
                        subTitle:
                            "${data.tanggalKembali} - ${data.waktuKembali}",
                      ),
                      TileTrip(
                        title: 'Tujuan wisata',
                        subTitle: data.tujuanWisata!,
                      ),
                      TileTrip(
                        title: 'Nilai Kontrak',
                        subTitle: Constant.formatRupiah(
                            int.parse(data.nilaiKontrak!)),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          body: Column(
            children: [
              NavBarTrip(),
              Container(
                height: Get.height * 0.33,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://www.udacity.com/blog/wp-content/uploads/2021/02/img8.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          color: Colors.white,
          height: Get.height * 0.22,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CIcon(
                    onTap: () async {
                      Pariwisata data =
                          await controller.getPariwisataByIdDetailPerjalanan();
                      Get.toNamed(Routes.CASHFLOW, arguments: {
                        "idTrip": data.idTripUtama,
                        "id": 1,
                      });
                    },
                    label: 'Pengeluaran\nBensin',
                    icons: Icons.widgets_outlined,
                  ),
                  CDivider(),
                  CIcon(
                    onTap: () async {
                      Pariwisata data =
                          await controller.getPariwisataByIdDetailPerjalanan();
                      Get.toNamed(Routes.CASHFLOW, arguments: {
                        "idTrip": data.idTripUtama,
                        "id": 2,
                      });
                    },
                    label: 'Pengeluaran\nLainnya',
                    icons: Icons.widgets_outlined,
                  ),
                  CDivider(),
                  CIcon(
                    onTap: () => Get.toNamed(Routes.CASHFLOW),
                    label: 'Pergantian\nDarurat',
                    icons: Icons.widgets_outlined,
                  ),
                ],
              ),
              const Gap(5),
              SlideAction(
                animationDuration: const Duration(milliseconds: 500),
                borderRadius: 12,
                elevation: 0,
                innerColor: Colors.white,
                outerColor: Colors.red[400],
                sliderButtonIconPadding: 10,
                height: 60,
                text: 'Selesaikan Perjalanan'.toUpperCase(),
                textStyle: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 15,
                ),
                onSubmit: () {
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: Text(
                        'Selesaikan Perjalanan',
                        style: GoogleFonts.outfit(),
                      ),
                      content: Text(
                        'Anda ingin menyelesaikan\nperjalanan ini?',
                        style: GoogleFonts.outfit(),
                      ),
                      actions: [
                        CupertinoDialogAction(
                          /// This parameter indicates this action is the default,
                          /// and turns the action's text to bold text.
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No'),
                        ),
                        CupertinoDialogAction(
                          /// This parameter indicates the action would perform
                          /// a destructive action such as deletion, and turns
                          /// the action's text color to red.
                          isDestructiveAction: true,
                          onPressed: () async {
                            Pariwisata data = await controller
                                .getPariwisataByIdDetailPerjalanan();
                            Get.toNamed(Routes.ODOMETER, arguments: {
                              "idTrip": data.idTripUtama,
                              "isTrue": true,
                            });
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  );
                  return null;
                },
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}

class TileTrip extends StatelessWidget {
  const TileTrip({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
        ),
        Text(
          subTitle,
          style: GoogleFonts.outfit(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const Gap(15),
      ],
    );
  }
}

class RatingBusTrip extends StatelessWidget {
  const RatingBusTrip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: const Color.fromARGB(255, 255, 219, 81),
        ),
        const Gap(5),
        Text(
          '9.2',
          style: GoogleFonts.outfit(),
        ),
      ],
    );
  }
}

class NavBarTrip extends StatelessWidget {
  const NavBarTrip({
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
              'Menu Perjalanan',
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

class CIcon extends StatelessWidget {
  CIcon({
    super.key,
    required this.label,
    required this.icons,
    this.onTap,
    this.colors = Colors.white,
  });

  final Color colors;
  final String label;
  final IconData? icons;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(10),
            color: colors,
            child: Column(
              children: [
                Icon(
                  icons,
                  color: Colors.black,
                  size: 30,
                ),
                Text(
                  label,
                  style: GoogleFonts.outfit(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CDivider extends StatelessWidget {
  const CDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 50,
      color: Colors.grey,
    );
  }
}
