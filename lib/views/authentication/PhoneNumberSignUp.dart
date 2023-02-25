import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh_mart/Logic/PhoneNumberMethods.dart';
import 'package:fresh_mart/constants/utilities.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../controllers/controllers.dart';
import '../../widgets/reusableTextFields.dart';
import '../../widgets/reusables.dart';

class PhoneNumberSignUpPage extends StatefulWidget {
  const PhoneNumberSignUpPage({Key? key}) : super(key: key);

  @override
  State<PhoneNumberSignUpPage> createState() => _PhoneNumberSignUpPageState();
}

class _PhoneNumberSignUpPageState extends State<PhoneNumberSignUpPage> {
  final GlobalKey<FormState> _myFormKey = GlobalKey<FormState>();
  FocusNode myFocusNode = FocusNode();
  File? image;
  final String alphabetWithSpaces = r'^[a-zA-Z ]+$';
  bool isLoadingPNSU = false;

  void stopLoading() {
    setState(() {
      isLoadingPNSU = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoadingOverlay(
        isLoading: isLoadingPNSU,
        progressIndicator: LoadingWidget(),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _myFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).splashColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  FilePickerResult? res =
                                      await FilePicker.platform.pickFiles();
                                  if (res != null) {
                                    setState(() {
                                      image = File(res.files.single.path!);
                                    });
                                  }
                                },
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 60.0,
                                      child: image == null
                                          ? Icon(
                                              Icons.account_circle,
                                              size: 130,
                                              color: Colors.green,
                                            )
                                          : Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 115,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: FileImage(image!),
                                                ),
                                              ),
                                            ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              MyCustomTextField(
                                labelText: 'Full Name',
                                hintText: 'Please enter your full name',
                                myController: signUpFullNameCtrl,
                                txtValueChecker: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please Enter Name'),
                                  PatternValidator(alphabetWithSpaces,
                                      errorText: 'Invalid Name !')
                                ]),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              IntlPhoneField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.countryCode != '+251') {
                                      return 'Invalid Country Code';
                                    } else if (value.completeNumber.isEmpty) {
                                      return 'Please Enter Phone Number';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    labelStyle:
                                        Theme.of(context).textTheme.bodySmall,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green)),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.lightGreen)),
                                  ),
                                  initialCountryCode: 'ET',
                                  onChanged: (phone) {
                                    userPhoneNumber = phone.completeNumber;
                                  }),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height: MediaQuery.of(context).size.height *
                                      0.063,
                                  margin: const EdgeInsets.all(25),
                                  child: CustomElevatedButton(
                                    label: 'Sign Up',
                                    myFormKey: _myFormKey,
                                    onTap: () async {
                                      setState(() {
                                        isLoadingPNSU = true;
                                      });
                                      if (_myFormKey.currentState!.validate()) {
                                        _myFormKey.currentState!.save();
                                        setState(() {
                                          isLoadingPNSU = true;
                                        });
                                        await MyPhoneMethods()
                                            .phoneNumberSignUp(context, image,
                                                userPhoneNumber, stopLoading);
                                      } else {
                                        isLoadingPNSU = false;
                                        showSnackBar(context, 'Invalid Input');
                                      }
                                    },
                                  )),
                            ]),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
