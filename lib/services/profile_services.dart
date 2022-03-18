import 'dart:convert';
import 'dart:io';
import 'package:brillo_connetz_app/components/constants.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as https;

import 'package:brillo_connetz_app/repos/api_status.dart';
import 'package:brillo_connetz_app/utility/shared_prefrences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class ProfileServices{


//update your username
  static Future<Object> updateUserName() async {
try{
    String userId = await UserPreferences().getUserId();
    String token = await UserPreferences().getToken();
    var body = json.encode({
      'authId': userId,
      'username': username,
    });
    var url = Uri.parse("${dotenv.env['BASE_URL']}/update-user-data");
    Response response = await https.put(url, headers: {'authorization': token,'Content-Type': 'application/json'}, body: body);
    final Map<String,dynamic> jsonDecoded = json.decode(response.body);

    if (jsonDecoded['status'] == true) {
      //get the users data
     // UsersViewModal().getUser(context);


      return Success(response: response);
    }
    return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
  } on HttpException {
  return Failure(code: USER_INVALID_RESPONSE,errorResponse:"Internal server error");
} on FormatException {
return Failure(code: INVALID_FORMAT,errorResponse:"Invalid format");
}on SocketException {
  return Failure(code:NO_INTERNET ,errorResponse: "No internet connection");
} catch (e) {
return Failure(code: UNKNOWN_ERROR,errorResponse:e);

}



  }




//update your phoneNumber
  static Future<Object> updatePhoneNumber() async {
    try{
    String userId = await UserPreferences().getUserId();
    String token = await UserPreferences().getToken();

    var body = json.encode({
      'authId': userId,
      'phoneNumber': phoneNumber,
    });
    var url = Uri.parse("${dotenv.env['UPDATE_PHONE_NUMBER']}");
    Response response = await https.put(url, headers: {'authorization': token,'Content-Type': 'application/json'}, body: body);
    final Map<String,dynamic> jsonDecoded = json.decode(response.body);

    if (jsonDecoded['status'] == true) {
      //get the users data
      Success(response: response);

      return Success(response: response);
    }
    return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
  } on HttpException {
  return Failure(code: NO_INTERNET,errorResponse:"Internal server error");
} on FormatException {
return Failure(code: USER_INVALID_RESPONSE,errorResponse:"Invalid format");
}on SocketException {
throw Exception("No internet connection");
} catch (e) {
return Failure(code: UNKNOWN_ERROR,errorResponse:e);

}

  }




//update your email address
  static Future<Object> updateEmailAddress() async {
    try{
    String userId = await UserPreferences().getUserId();
    String token = await UserPreferences().getToken();
    var result = await UserPreferences().getUser();

    var body = json.encode({
      'authId': userId,
      'newEmail': emailAddress,
      'oldEmail':result.email,
      'phoneNumber':phoneNumber

    });
    var url = Uri.parse("${dotenv.env['BASE_URL']}/update-email");
    Response response = await https.put(url, headers: {'authorization': token,'Content-Type': 'application/json'}, body: body);
    final Map<String,dynamic> jsonDecoded = json.decode(response.body);

    if (jsonDecoded['status'] == true) {

      //get the users data

      return Success(response: response);
    }
    return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
  } on HttpException {
      return Failure(code: NO_INTERNET,errorResponse:"No internet");
  } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE,errorResponse:"Invalid format");
    }on SocketException {
throw Exception("Internal server error");
} catch (e) {
      return Failure(code: UNKNOWN_ERROR,errorResponse:e);

}

  }



//update your email address
  static Future<Object> deletedAccount() async {
    try{
      String userId = await UserPreferences().getUserId();
      String token = await UserPreferences().getToken();


      var body = json.encode({
        'authId': userId,

      });
      var url = Uri.parse("${dotenv.env['BASE_URL']}/delete-user");
      Response response = await https.delete(url, headers: {'authorization': token,'Content-Type': 'application/json'}, body: body);
      final Map<String,dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        //get the users data

        return Success(response: response);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET,errorResponse:"No internet");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE,errorResponse:"Invalid format");
    }on SocketException {
      throw Exception("Internal server error");
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR,errorResponse:e);

    }

  }




}