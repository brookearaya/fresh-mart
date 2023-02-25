import 'dart:io';
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

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authentication>(context);
    final user = Provider.of<Authentication>(context).userList;
    String oldName = user[0].fullName.toString();
    TextEditingController editFullName = TextEditingController();
    return LoadingOverlay(
      isLoading: isLoadingEditProfile,
      progressIndicator: LoadingWidget(),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.25,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    MyCustomTextField(
                        hintText: 'Enter Your New Name',
                        labelText: 'Previous Name: $oldName',
                        myController: editFullName),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextField(
                      enabled: false,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText:
                            FirebaseAuth.instance.currentUser?.phoneNumber,
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                      ),
                    )
                  ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ElevatedButton(
                    onPressed: () async{
                      setState(() {
                        isLoadingEditProfile = true;
                      });
                      await auth.profileUpdate(editFullName.text, context);
                      setState(() {
                        isLoadingEditProfile = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text('Update'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
