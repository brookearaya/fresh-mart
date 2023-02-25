import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/address/address.dart';
import 'package:fresh_mart/constants/constants.dart';
import 'package:fresh_mart/services/authentication.dart';
import 'package:fresh_mart/services/order-service.dart';
import 'package:fresh_mart/widgets/reusables.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../widgets/OtherWidgets.dart';
import '../authentication/edit_profile.dart';
import 'package:fresh_mart/routes/routes.dart' as routes;

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String? phone = FirebaseAuth.instance.currentUser?.phoneNumber;
  File? updateImage;

  @override
  void initState() {
    Provider.of<Authentication>(context, listen: false).showProfile(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String format = 'http://192.168.0.41:4000/profileImg/$phone.png';
    var profile = Provider.of<Authentication>(context);
    //var orderService = Provider.of<OrderService>(context);

    //print(Provider.of<Authentication>(context).userList);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
          actions: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => EditProfile());
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  primary: Colors.transparent,
                  elevation: 0,
                  onPrimary: Theme.of(context).iconTheme.color),
              child: Icon(Icons.edit),
            )
          ],
        ),
        backgroundColor: Colors.green.withOpacity(0.03),
        body: SafeArea(
          child: Center(
            child: profile.isLoading
                ? LoadingWidget()
                : LoadingOverlay(
                    isLoading: isLoadingEditProfile,
                    progressIndicator: LoadingWidget(),
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    FilePickerResult? res =
                                        await FilePicker.platform.pickFiles();
                                    if (res != null) {
                                      setState(() {
                                        isLoadingEditProfile = true;
                                        updateImage =
                                            File(res.files.single.path!);
                                      });
                                      print(updateImage);
                                      await Authentication(context)
                                          .sendImageAndPhoneNumber(
                                              updateImage, context);
                                      setState(() {
                                        isLoadingEditProfile = false;
                                      });
                                    }
                                  },
                                  child: updateImage == null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          child: CachedNetworkImage(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.23,
                                            imageUrl: format,
                                            fit: BoxFit.fill,
                                            progressIndicatorBuilder:
                                                (context, url, progress) =>
                                                    LoadingWidget(),
                                            errorWidget: (context, url,
                                                    progress) =>
                                                Container(
                                                    decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image:
                                                    NetworkImage(defaultImage),
                                              ),
                                            )),
                                          ),
                                        )
                                      : Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 115,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(updateImage!),
                                            ),
                                          ),
                                        ),
                                ),
                                Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        shape: BoxShape.circle),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.edit_note_outlined,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(profile.userList[0].fullName,
                                style: Theme.of(context).textTheme.overline),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Column(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       'Orders',
                                    //       style: TextStyle(
                                    //           fontSize: 18,
                                    //           fontWeight: FontWeight.bold),
                                    //     ),
                                    //     Text(order .count.toString(),
                                    //         style: TextStyle(
                                    //           fontSize: 15,
                                    //         ))
                                    //   ],
                                    // ),
                                    // Column(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       'Spent',
                                    //       style: TextStyle(
                                    //           fontSize: 18,
                                    //           fontWeight: FontWeight.bold),
                                    //     ),
                                    //     Text('ETB100',
                                    //         style: TextStyle(fontSize: 15))
                                    //   ],
                                    // )
                                  ],
                                )),
                            Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                      color: Colors.green.withOpacity(0.1),
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Login and Security',
                                              style: TextStyle(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          SettingButtons(
                                              icon: Icons.help_outline_outlined,
                                              text: 'Help & Support',
                                              btnPress: () {}),
                                          SettingButtons(
                                              icon: Icons.privacy_tip_outlined,
                                              text: 'Privacy Policy',
                                              btnPress: () {}),
                                          SettingButtons(
                                              icon: Icons.wysiwyg_outlined,
                                              text: 'Terms & Condition',
                                              btnPress: () {}),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Data and Permissions',
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          SettingButtons(
                                            icon: Icons.location_on_outlined,
                                            text: 'Delivery Address',
                                            btnPress: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          Address());
                                            },
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          SettingButtons(
                                              icon:
                                                  Icons.shopping_cart_outlined,
                                              text: 'Previous Orders',
                                              btnPress: () {}),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          SettingButtons(
                                              icon: Icons
                                                  .favorite_border_outlined,
                                              text: 'Wishlist',
                                              btnPress: () {}),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                      color: Colors.red.withOpacity(0.1),
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(children: [
                                              ConstrainedBox(
                                                constraints:
                                                    BoxConstraints.tightFor(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.06),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    profile.logout(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors
                                                              .transparent,
                                                          onPrimary: Colors.red,
                                                          shadowColor: Colors
                                                              .transparent,
                                                          elevation: 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(children: [
                                                        Icon(
                                                          Icons.logout_outlined,
                                                          color: Colors.red,
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.04,
                                                        ),
                                                        Text(
                                                          'Logout',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        )
                                                      ]),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
