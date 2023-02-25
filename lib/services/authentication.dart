import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fresh_mart/constants/constants.dart';
import 'package:fresh_mart/models/user-model.dart';
import 'package:fresh_mart/services/exceptions.dart';
import 'package:http/http.dart' as http;
import '../constants/utilities.dart';
import 'package:http_parser/http_parser.dart';
import 'package:fresh_mart/routes/routes.dart' as route;

class Authentication with ChangeNotifier {
  var user;

  bool isLoading = true;
  Authentication(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;
    showProfile(context);
    print(isLoading);
  }
  Future<void> sendImageAndPhoneNumber(
      File? image, BuildContext context) async {
    DefaultCacheManager manager = DefaultCacheManager();
    manager.emptyCache(); //clears all data in cache.
    try {
      FormData formData = FormData.fromMap({
        'userImage': await MultipartFile.fromFile(image!.path,
            filename: '${user!.phoneNumber!}.png',
            contentType: MediaType('image', 'png')),
        'phoneNumber': FirebaseAuth.instance.currentUser?.phoneNumber
      });
      Dio dio = Dio();
      await dio.post('http://192.168.0.41:4000/changeProfilePicture',
          data: formData,
          options: Options(headers: {
            "accept": "*/*",
            "Content-Type": "multipart/form-data"
          }));
      showSnackBar(context, 'Success !');
    } on DioError catch (e) {
      showSnackBar(context, DioExceptions.fromDioError(e).toString());
    }
  }

  Future<void> signUpUser({
    required BuildContext context,
    File? imgFile,
    required String phone,
    required String name,
    String? userAddress,
  }) async {
    try {
      UserModel user = UserModel(
        id: '',
        fullName: name,
        phoneNumber: phone,
        userProfile: imgFile == null ? defaultImage : imgFile.path,
      );
      FormData formData = FormData.fromMap({
        'fullName': user.fullName,
        'phoneNumber': user.phoneNumber,
        'userProfileUrl': user.userProfile,
        'userImage': imgFile == null
            ? user.userProfile
            : await MultipartFile.fromFile(imgFile.path,
                filename:
                    '${user.phoneNumber}.png', // replace imgFile.path.split('/').last
                contentType: MediaType('image', 'png')),
      });
      Dio dio = Dio();
      var statusResponse = await dio.post(
          'http://192.168.0.41:4000/checkStatus',
          data: json.encode({'phoneNumber': user.phoneNumber}));
      print('status $statusResponse');
      if (statusResponse.toString() == "User Not Found") {
        try {
          await dio.post("http://192.168.0.41:4000/userSignUp",
              data: formData,
              options: Options(headers: {
                "accept": "*/*",
                "Content-Type": "multipart/form-data"
              }));
          Navigator.pushNamed(context, route.MainPage);
        } on DioError catch (e) {
          showSnackBar(context, DioExceptions.fromDioError(e).toString());
          Navigator.pushNamed(context, route.LOGIN);
        }
      }
      var response = await dio.post("http://192.168.0.41:4000/checkUser",
          data: json.encode({'phoneNumber': user.phoneNumber}));
      print('user found: $response');
      if (response.toString() == 'User Exists') {
        if (statusResponse.toString() == 'Disabled') {
          showSnackBar(context, 'Your account has been disabled');
          Navigator.pushNamed(context, route.LOGIN);
        } else {
          showSnackBar(context, 'Welcome Back');
          Navigator.pushNamed(context, route.MainPage);
        }
      }
    } on DioError catch (e) {
      Navigator.of(context).pop();
      showSnackBar(context, DioExceptions.fromDioError(e).toString());
    }
  }

  List<UserModel> userList = [];
  Future<void> showProfile(BuildContext context) async {
    var phone = await FirebaseAuth.instance.currentUser!.phoneNumber;
    print(phone);
    try {
      Uri uri = Uri.parse('http://192.168.0.41:4000/getUserProfile');
      var response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode({'phoneNumber': phone}));
      var responseData = json.decode(response.body);
      if (responseData == null) {
        isLoading = false;
        notifyListeners();
      }
      Map<String, dynamic> data = responseData;
      userList.add(UserModel(
          id: data['_id'],
          fullName: data['fullName'],
          phoneNumber: data['phoneNumber'],
          userProfile: data['userProfileUrl']));
      isLoading = false;
      notifyListeners();
    } catch (e) {
      showSnackBar(context, 'Unable To Fetch Profile');
    }
  }

  NetworkImage getUserImage() {
    String? phone = FirebaseAuth.instance.currentUser?.phoneNumber;
    String format = '${phone!}.png';
    String uri = 'http://192.168.0.41:4000/profileImg/$format';
    return NetworkImage(uri);
  }

  get() async {
    String? phone = FirebaseAuth.instance.currentUser?.phoneNumber;
    String format = phone! + '.png';
    Uri uri = Uri.parse('http://192.168.0.41:4000/getUserProfilePicture');
    FormData formData = FormData.fromMap({'fileName': format});
    Dio dio = Dio();
    var response = await dio.post(uri.toString(),
        data: formData,
        options: Options(
            headers: {"accept": "*/*", "Content-Type": "multipart/form-data"}));
    return response.data;
  }

  Future<void> profileUpdate(String fullName, BuildContext context) async {
    String phone = await FirebaseAuth.instance.currentUser!.phoneNumber!;
    Dio dioPut = Dio();
    try {
      await dioPut.put('http://192.168.0.41:4000/editProfile',
          data: jsonEncode({
            'fullName': fullName,
            'phoneNumber': phone,
          }));
      showSnackBar(context, "Success!");
    } on DioError catch (e) {
      showSnackBar(context, DioExceptions.fromDioError(e).toString());
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popAndPushNamed(context, route.LOGIN);
  }

  Future<void> addAddress(String address, BuildContext context) async {
    try {
      String phoneAddress =
          await FirebaseAuth.instance.currentUser!.phoneNumber!;
      Dio dioAddress = Dio();
      await dioAddress.post('http://192.168.0.41:4000/addAddress',
          data: jsonEncode({
            'userAddress': address,
            'phoneNumber': phoneAddress,
          }));
      showSnackBar(context, 'Address Changed !');
    } on DioError catch (e) {
      print(e);
      showSnackBar(context, DioExceptions.fromDioError(e).toString());
    }
  }
}
