import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/widgets/reusables.dart';
import 'package:fresh_mart/widgets/search.dart';

import '../constants/constants.dart';

class HeaderWithSearchBox extends StatelessWidget {
  String? phone = FirebaseAuth.instance.currentUser?.phoneNumber;

  @override
  Widget build(BuildContext context) {
    String format = 'http://192.168.0.41:4000/profileImg/$phone.png';
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          height: MediaQuery.of(context).size.height * 0.23,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [Icon(Icons.location_on_outlined),
                        Text(
                          'Addis Ababa, ETHIOPIA',
                          style: Theme.of(context).textTheme.overline,
                        ),
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.arrow_drop_down))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: CachedNetworkImage(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.13,
                            imageUrl: format,
                            fit: BoxFit.fill,
                            progressIndicatorBuilder:
                                (context, url, progress) => LoadingWidget(),
                            errorWidget: (context, url, progress) => Container(
                                decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(50),
                              color: Colors.green,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(defaultImage),
                              ),
                            )),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.notification_important_outlined,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              primary: Theme.of(context).cardColor,
                              shape: CircleBorder()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [DefaultTextStyle(
                    style: const TextStyle(color: Color(0x797AA47A),
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      fontFamily: 'SquarePeg-Regular',
                    ),
                    child: AnimatedTextKit(repeatForever: false,totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText('Fresh Mart, your local grocery store is \navailable to assist you.')
                      ],
                    ),
                  ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        // margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 54,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SearchBar()),
                    ElevatedButton(
                      onPressed: () {},
                      child: Icon(
                        EvaIcons.options2,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
