import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/views/authentication/PhoneNumberSignUp.dart';
import 'package:fresh_mart/widgets/bottomnavbar.dart';
import 'package:fresh_mart/widgets/reusables.dart';

class AuthStatePage extends StatefulWidget {
  const AuthStatePage({Key? key}) : super(key: key);

  @override
  State<AuthStatePage> createState() => _AuthStatePageState();
}

class _AuthStatePageState extends State<AuthStatePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return LoadingWidget();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Something Went Wrong'),
              );
            } else if (snapshot.hasData) {
              return DisplayNavBar();
            } else {
              return PhoneNumberSignUpPage();
            }
          },
        ),
      );
}
