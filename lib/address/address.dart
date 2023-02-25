import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fresh_mart/constants/constants.dart';
import 'package:fresh_mart/constants/utilities.dart';
import 'package:fresh_mart/services/authentication.dart';
import 'package:fresh_mart/widgets/reusables.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../widgets/reusableTextFields.dart';
import 'package:fresh_mart/routes/routes.dart' as routes;

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  TextEditingController textAddress = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var addressProvider = Provider.of<Authentication>(context);
    return LoadingOverlay(
      isLoading: isLoadingAddress,
      progressIndicator: LoadingWidget(),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.25,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyCustomTextField(
                  labelText: 'Address',
                  hintText: 'Please enter your current Address',
                  myController: textAddress,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () async {
                      setState(() {
                        isLoadingAddress = true;
                      });
                      await addressProvider.addAddress(
                          textAddress.text, context);
                      setState(() {
                        isLoadingAddress = false;
                      });
                    },
                    child: AutoSizeText('Set Address'))
              ]),
        ),
      ),
    );
  }
}
