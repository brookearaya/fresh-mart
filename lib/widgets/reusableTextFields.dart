import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:validators/validators.dart';

//custom Password field
class MyCustomPassword extends StatefulWidget {
  String lblPassword;
  String hintPassword;
  TextEditingController passwordCtrl;
  String? Function(String?)? passwordChecker;

  @override
  State<MyCustomPassword> createState() => _MyCustomPasswordState();

  MyCustomPassword(
      {Key? key,
      required this.lblPassword,
      required this.hintPassword,
      required this.passwordCtrl,
      required this.passwordChecker})
      : super(key: key);
}

class _MyCustomPasswordState extends State<MyCustomPassword> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = FocusNode();
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.passwordChecker,
      controller: widget.passwordCtrl,
      obscureText: _isObscure,
      decoration: InputDecoration(
          labelText: widget.lblPassword,
          hintText: widget.hintPassword,
          labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.black : Colors.black,
              fontWeight: FontWeight.normal),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
          suffixIcon: IconButton(
              color: Colors.green,
              icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              })),
    );
  }
}

// custom phone field

class MyCustomPhoneTextField extends StatelessWidget {
  String hintText;
  String labelText;
  TextEditingController myController;
  //Future<String?> Function(PhoneNumber?)? phoneChecker;

  MyCustomPhoneTextField({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.myController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = FocusNode();
    return IntlPhoneField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.countryCode != '+251') {
          return 'Invalid Country Code';
        } else if (value.completeNumber.isEmpty) {
          return 'Please Enter Phone Number';
        }
      },
      controller: myController,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        labelStyle: TextStyle(
            color: myFocusNode.hasFocus ? Colors.black : Colors.black,
            fontWeight: FontWeight.normal),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      initialCountryCode: 'ET',
    );
  }
}

/// custom text input field

class MyCustomTextField extends StatelessWidget {
  String hintText;
  String labelText;
  TextEditingController myController;
  String? Function(String?)? txtValueChecker;

  MyCustomTextField(
      {required this.hintText,
      required this.labelText,
      required this.myController,
      this.txtValueChecker});

  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = FocusNode();
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: myController,
      validator: txtValueChecker,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.labelMedium,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightGreen)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
      ),
    );
  }
}
