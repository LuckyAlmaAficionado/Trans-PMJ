import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trans/app/controllers/auth_controller.dart';
import 'package:trans/app/utils/splash_screen.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 2)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            title: "Trans PO.PMJ",
            theme: ThemeData(
              useMaterial3: true,
              textTheme: GoogleFonts.outfitTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            debugShowCheckedModeBanner: false,
            initialRoute:
                (authC.isLogin.isTrue) ? Routes.HOME : AppPages.INITIAL,
            getPages: AppPages.routes,
          );
        }

        return FutureBuilder(
          future: authC.autoLogin(),
          builder: (context, snapshot) => SplashScreen(),
        );
      },
    );
  }
}
