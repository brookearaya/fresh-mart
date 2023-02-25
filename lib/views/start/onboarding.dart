import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:fresh_mart/routes/routes.dart' as routes;
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  checkFirstLaunch() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', true);
  }

  @override
  Widget build(BuildContext context)  {
    checkFirstLaunch();
    var screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Stack(
          children: [
            CustomPaint(
              painter: ArcPainter(),
              child: SizedBox(
                height: screenSize.height / 1.4,
                width: screenSize.width,
              ),
            ),
            Positioned(
              top: 130,
              right: 5,
              left: 5,
              child: Lottie.asset(
                tabs[_currentIndex].lottieFile,
                key: Key('${Random().nextInt(999999999)}'),
                width: 600,
                alignment: Alignment.topCenter,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 270,
                child: Column(
                  children: [
                    Flexible(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: tabs.length,
                        itemBuilder: (BuildContext context, int index) {
                          OnboardingModel tab = tabs[index];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                tab.title,
                                style: const TextStyle(
                                    fontSize: 27.0,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: 'TitanOne-Regular'),
                              ),
                              const SizedBox(height: 50),
                              Text(
                                tab.subtitle,
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.center,
                              )
                            ],
                          );
                        },
                        onPageChanged: (value) {
                          _currentIndex = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int index = 0; index < tabs.length; index++)
                          _DotIndicator(isSelected: index == _currentIndex),
                      ],
                    ),
                    const SizedBox(height: 65)
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_currentIndex == 2) {
              _pageController.animateToPage(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
              Navigator.pushNamed(context, routes.CheckStatus);
            } else {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            }
          },
          backgroundColor: Colors.white,
          child: const Icon(CupertinoIcons.chevron_right, color: Colors.green),
        ),
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path orangeArc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 170)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 200)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _DotIndicator extends StatelessWidget {
  final bool isSelected;

  const _DotIndicator({Key? key, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 6.0,
        width: 6.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.green : Colors.green[100],
        ),
      ),
    );
  }
}

class OnboardingModel {
  final String lottieFile;
  final String title;
  final String subtitle;

  OnboardingModel(this.lottieFile, this.title, this.subtitle);
}

List<OnboardingModel> tabs = [
  OnboardingModel(
    'assets/animations/73982-healthy-or-junk-food.json',
    'Choose Fresh Products',
    'When you order our Fresh Products, \nWe\'ll deliver them to your \nLocation.',
  ),
  OnboardingModel(
    'assets/animations/lf20_ptfmt0ts.json',
    'Just Send Us Your Location',
    'We make it simple to find the \nFresh Products you need. Send us your \naddress We will deliver',
  ),
  OnboardingModel(
    'assets/animations/lf30_editor_rdfghsjh.json',
    'Pick Up',
    'Or We bring our Fresh products at your door steps ,\n simple and free - no matter when you \norder',
  ),
];
