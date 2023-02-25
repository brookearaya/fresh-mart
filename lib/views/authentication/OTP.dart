import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/services/authentication.dart';
import 'package:fresh_mart/widgets/reusables.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../controllers/controllers.dart';
import 'package:fresh_mart/routes/routes.dart' as route;

class OtpPage extends StatefulWidget {
  final String verId;
  final int? resTok;
  final File? file;

  @override
  _OtpPageState createState() => _OtpPageState();

  OtpPage({Key? key, required this.verId, this.resTok, this.file}) : super(key: key);
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authentication>(context);
    return LoadingOverlay(
      color: Theme.of(context).backgroundColor,
      isLoading: isLoadingOTPage,
      progressIndicator: LoadingWidget(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Sign Up',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.green,
            onPressed: () {
              Navigator.pushNamed(context, route.LOGIN);
            },
          ),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).canvasColor,
        body: SafeArea(
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).splashColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text(
                            'Verification',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            "Please Enter Your OTP",
                            style: Theme.of(context).textTheme.labelMedium,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.028,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    textFieldOTP(
                                        context: context,
                                        first: true,
                                        last: false,
                                        otpController: firstOtp),
                                    textFieldOTP(
                                        context: context,
                                        first: false,
                                        last: false,
                                        otpController: secondOtp),
                                    textFieldOTP(
                                        context: context,
                                        first: false,
                                        last: false,
                                        otpController: thirdOtp),
                                    textFieldOTP(
                                        context: context,
                                        first: false,
                                        last: false,
                                        otpController: fourthOtp),
                                    textFieldOTP(
                                        context: context,
                                        first: false,
                                        last: false,
                                        otpController: fifthOtp),
                                    textFieldOTP(
                                        context: context,
                                        first: false,
                                        last: true,
                                        otpController: sixthOtp),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height: MediaQuery.of(context).size.height *
                                      0.063,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        isLoadingOTPage = true;
                                      });
                                      String smsCode = firstOtp.text.trim() +
                                          secondOtp.text.trim() +
                                          thirdOtp.text.trim() +
                                          fourthOtp.text.trim() +
                                          fifthOtp.text.trim() +
                                          sixthOtp.text.trim();
                                      PhoneAuthCredential credential =
                                          PhoneAuthProvider.credential(
                                              verificationId: widget.verId,
                                              smsCode: smsCode);
                                      await FirebaseAuth.instance
                                          .signInWithCredential(credential)
                                          .then((value) => auth
                                              .signUpUser(
                                                  context: context,
                                                  name: signUpFullNameCtrl.text,
                                                  phone: userPhoneNumber,
                                                  imgFile: widget.file)
                                              .onError(
                                                (error, stackTrace) =>
                                                    setState(() {
                                                  isLoadingOTPage = false;
                                                }),
                                              ));
                                      setState(() {
                                        isLoadingOTPage = false;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green),
                                    child: Text('Verify'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.028,
                          ),
                          Text(
                            "Didn't you receive any code?",
                            style: Theme.of(context).textTheme.labelMedium,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.018,
                          ),
                          Text(
                            "Resend New Code",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
