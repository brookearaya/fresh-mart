import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/constants/utilities.dart';
import '../views/authentication/OTP.dart';

class MyPhoneMethods {
  Future<void> phoneNumberSignUp(context, image, userPhoneNumber, stopLoading) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    print("inside");
    await auth.verifyPhoneNumber(
        phoneNumber: userPhoneNumber,
        verificationCompleted: (PhoneAuthCredential cred) async {
          await FirebaseAuth.instance
              .signInWithCredential(cred)
              .then((value) => {stopLoading}).onError((error, stackTrace) => stopLoading);
        },
        verificationFailed: (e) {
          stopLoading();
          showSnackBar(context, 'Unable to Complete Verification because ' + e.message.toString());
          print(e.toString());
        },
        codeSent: ((String verId, int? resTok) async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => OtpPage(
                        verId: verId,
                        resTok: resTok,
                        file: image,
                      )));
        }),
        codeAutoRetrievalTimeout: (String verId) {});
  }
}
