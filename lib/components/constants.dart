import 'dart:math';

import 'package:brillo_connetz_app/models/match_modal.dart';
import 'package:brillo_connetz_app/utility/colors.dart';
import 'package:brillo_connetz_app/utility/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

Widget space(BuildContext context)=> SizedBox(height: MediaQuery.of(context).size.height * 0.08);

Widget spacing(BuildContext context)=> SizedBox(height: MediaQuery.of(context).size.height * 0.02);

String? firstName = '';
String? username = '';
String? lastName = '';
String? interest = '';
String? profileImageUrl;
String? phoneNumber = '';
String? emailAddress = '';
String? loginData;
String? password = '';
String phoneCode = '';

const USER_INVALID_RESPONSE = 101;
const NO_INTERNET = 102;
const INVALID_FORMAT = 103;
const UNKNOWN_ERROR = 104;

String? otpText;
var getUsers = <MatchUsersModel>[];
final TextEditingController userInterest = TextEditingController();
//var userGroupContacts = [];
 notifyFlutterToastSuccess({required title})async{
  // String title;
  Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: kBlackColor,
      textColor: Colors.greenAccent);
}

 notifyFlutterToastError({required title})async{
  // String title;
  Fluttertoast.showToast(
      timeInSecForIosWeb: 10,
      msg: title,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: kBlackColor,
      textColor: kRedColor);
}



