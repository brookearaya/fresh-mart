import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitSpinningLines(
      color: Colors.green,
      size: 70.0,
      duration: const Duration(milliseconds: 1500),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    Key? key,
    required this.onTap,
    required GlobalKey<FormState> myFormKey,
    required this.label
  })  : myFormKey = myFormKey,
        super(key: key);

  final GlobalKey<FormState> myFormKey;
  VoidCallback onTap;
  String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          primary: Colors.green),
      child: Text(label),
    );
  }
}


 Widget textFieldOTP(
      {required bool first,
      last,
      required context,
      required TextEditingController otpController}) {
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height * 0.06,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: otpController,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.lightGreen),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.green),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }