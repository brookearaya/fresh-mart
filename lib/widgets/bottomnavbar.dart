import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/views/app/order.dart';
import '../views/app/Landing_Page.dart';
import '../views/app/account.dart';

class DisplayNavBar extends StatefulWidget {
  const DisplayNavBar({Key? key}) : super(key: key);

  @override
  State<DisplayNavBar> createState() => _DisplayNavBarState();
}

class _DisplayNavBarState extends State<DisplayNavBar> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      body: [Home(), Order(), Setting()][selectedPage],
      bottomNavigationBar: FloatingNavbar(
        onTap: (int i) => setState(() => selectedPage = i),
        currentIndex: selectedPage,
        selectedBackgroundColor: Colors.green,
        elevation: 0,
        backgroundColor: Theme.of(context).navigationBarTheme.backgroundColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Theme.of(context).hintColor,
        items: [
          FloatingNavbarItem(icon: Icons.home_outlined, title: 'Home'),
          FloatingNavbarItem(icon: Icons.receipt_long_outlined, title: 'Orders'),
          FloatingNavbarItem(
              icon: Icons.account_circle_outlined, title: 'Account'),
        ],
      ),
    );
  }
}
