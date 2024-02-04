import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:trans/app/models/users.dart';
import 'package:trans/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  // firebase ....
  FirebaseAuth _authC = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //  ....
  var isLogin = false.obs;

  // credential
  UserCredential? userCredential;
  var user = UserModel().obs;

  // initial
  Future<void> autoLogin() async {
    try {
      String userId = await _authC.currentUser!.uid;

      if (userId.isNotEmpty) {
        isLogin(true);
      }
    } catch (e) {
      throw (e);
    }
  }

  // login app
  Future<void> login(String email, String password) async {
    try {
      final response = await _authC
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => userCredential = value);

      // check response
      if (response.user != null) {
        // jika user terdaftar di authentication ....

        // cek apakah sudah terdaftar di database
        CollectionReference users = firestore.collection('users');
        final curUsers = await users.doc(response.user!.email).get();

        if (curUsers.data() == null) {
          // jika pengguna belum terdaftar di database

          // daftarkan pengguna kedalam firebase

          // mendaftarkan kedalam database
          users
              .doc(response.user!.email)
              .set(
                UserModel(
                  docId: '',
                  nama: userCredential!.user!.displayName,
                  username: userCredential!.user!.displayName,
                  email: email,
                  nope: '',
                  status: 0,
                  role: 'supir',
                  alamat: '',
                  createdAt: userCredential!.user!.metadata.creationTime!
                      .toIso8601String(),
                  lastLogin: userCredential!.user!.metadata.lastSignInTime!
                      .toIso8601String(),
                  updateAt: userCredential!.user!.metadata.lastSignInTime!
                      .toIso8601String(),
                  deleteAt: '',
                ).toJson(),
              )
              .then(
                (value) => print('input data berhasil'),
                onError: (error) => print('error add data: $error'),
              );
        }

        // mendapatkan data pengguna
        final currentUser = await users.doc(email).get();
        final currentUserData =
            await currentUser.data() as Map<String, dynamic>;

        // set data user untuk global
        user.value = UserModel.fromJson(currentUserData);

        // jika pengguna sudah terdaftar di database
        Get.offAllNamed(Routes.HOME);
      } else {
        // jika tidak terdaftar
      }
    } on FirebaseAuthException catch (e) {
      print('error login auth_controller: $e');
    }
  }
}
