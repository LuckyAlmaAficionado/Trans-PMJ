import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trans/app/constant/constant.dart';
import 'package:http/http.dart' as http;
import 'package:trans/app/routes/app_pages.dart';

class LoginController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  String? token;

  createNewAccount() async {
    Uri url = Uri.parse("${Constant.REALTIME_DATABASE}/users.json?auth=$token");

    var body = json.encode({
      "createdAt": DateTime.now().toIso8601String(),
      "updateAt": DateTime.now().toIso8601String(),
      "deleteAt": "",
      "id": FirebaseAuth.instance.currentUser!.uid,
      "username": "",
      "nama": "",
      "alamat": "",
      "nope": "",
      "email": email.text,
      "status": 0,
      "last_login": DateTime.now().toIso8601String(),
      "role": "driver",
    });

    try {
      var response = await http.post(
        url,
        body: body,
      );

      if (response.statusCode == 200) {
        print('berhasil');
      } else {
        throw Exception('gagal membuat akun ${response.statusCode}');
      }
    } catch (e) {
      throw e;
    }
  }

  signIn(String email, String password) async {
    checkCondition(email, password);
    try {
      // sign in with email
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // set token
      token = await FirebaseAuth.instance.currentUser!.getIdToken();

      Constant.snackbar('Congratulations!', 'Login successful.', true);
      await Future.delayed(const Duration(seconds: 2));
      // to home
      Get.toNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Constant.snackbar('Error', 'No user found for that email.', false);
      } else if (e.code == 'wrong-password') {
        Constant.snackbar(
            'Error', 'Wrong password provided for that user.', false);
      } else {
        // Handle other FirebaseAuthException types as needed.
        Constant.snackbar('Oh Snap!', 'account not found.', false);
      }
      throw e;
    } catch (e) {
      // Handle other types of exceptions as needed.
      Constant.snackbar('Error', 'An unexpected error occurred.', false);
      throw e;
    }
  }

  checkCondition(String email, String password) {
    if (email.isEmpty && password.isEmpty) {
      Constant.snackbar('Oh Snap!', "The field cannot be empty.", false);
    } else if (!email.contains("@") && !email.contains('.')) {
      Constant.snackbar('Oh Snap!', "Incorrect email format.", false);
    } else if (password.length < 6) {
      Constant.snackbar('Oh Snap!', "Minimum password length 6.", false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    print('init login controller');
    email = TextEditingController(text: 'lucky@gmail.com');
    password = TextEditingController(text: 'luckyy');
  }

  @override
  void onClose() {
    email.clear();
    password.clear();
    super.onClose();
  }

  Future<void> signUp(String email, String password) async {
    try {
      var response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      print(response);

      token = await FirebaseAuth.instance.currentUser!.getIdToken();

      createNewAccount();
    } catch (e) {
      throw e;
    }
  }
}
