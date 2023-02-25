import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fresh_mart/routes/routes.dart' as route;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    navigateToLogin();
  }

  navigateToLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isFirstLaunch = prefs.getBool('isFirstLaunch');
    if(isFirstLaunch != null ){
      if(!isFirstLaunch){
        print("yes first launch");
        await Future.delayed(Duration(milliseconds:6300), () {});
        Navigator.pushNamed(context, route.OBS);
      }else
        Navigator.pushNamed(context, route.MainPage);
    }
    else  Navigator.pushNamed(context, route.OBS);

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(backgroundColor: Colors.green,
        body: SafeArea(
          child: Center(
            child: TextLiquidFill(
              text: 'Fresh Mart',
              waveColor: Colors.white,
              boxBackgroundColor: Colors.green,
              textStyle: TextStyle(
                  fontFamily: 'Fascinate-Regular', fontSize: 50),
              textAlign: TextAlign.center,
              // boxHeight: 300.0,
            ),
          ),
        ),
      ),
    );
  }
}
