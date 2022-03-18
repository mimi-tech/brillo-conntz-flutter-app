import 'dart:convert';
import 'dart:io';
import 'package:brillo_connetz_app/components/constants.dart';
import 'package:brillo_connetz_app/models/new_user.dart';
import 'package:brillo_connetz_app/repos/api_status.dart';
import 'package:brillo_connetz_app/utility/shared_prefrences.dart';
import 'package:brillo_connetz_app/view_model/users_Auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as https;
import 'package:provider/provider.dart';


class AuthServices {
  //for login

  static Future<Object> loginUser(BuildContext context) async {
    try {

      var body = json.encode({
        'email': emailAddress,
        'phoneNumber':emailAddress,
        'password': password
      });

      var url = Uri.parse("${dotenv.env['BASE_URL']}/login");
      Response response = await https.post(url, headers: {'Content-Type': 'application/json'}, body: body);

      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {
       print(response.body);
        var userData = jsonDecoded['data'];
        var token = jsonDecoded['token'];
        NewUser authUser = NewUser.fromJson(userData);
        UserPreferences().saveUser(authUser);

        UserPreferences().saveToken(token);
        UserPreferences().saveAuthId(userData['_id']);
        Provider.of<UserProvider>(context, listen: false).setUser(authUser);
        return Success(response: response);
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e);
    }
  }

//Register a user
  static Future<Object> registerUser() async {
    try {

      var body = json.encode({
        'firstName':firstName,
        'lastName':lastName,
        'interest':interest,
        'username':username,
        'profileImageUrl':profileImageUrl,
        'phoneNumber':phoneNumber,
        'email': emailAddress,
        'password': password,
      });
      var url = Uri.parse("${dotenv.env['BASE_URL']}/create-user-account");
      Response response = await https.post(url, headers: {'Content-Type': 'application/json'}, body: body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {
        //save the user id in shared preferences
        var userData = jsonDecoded['data'];
        UserPreferences().saveAuthId(userData['id']);
        NewUser authUser = NewUser.fromJson(userData);
        UserPreferences().saveUser(authUser);
        return Success(response: response);
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");

    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e);
    }
  }




  //reset password
  static Future<Object> resetPassword() async {
    try {

      var body = json.encode({
        'email': emailAddress,
        'password': password
      });
      var url = Uri.parse("${dotenv.env['BASE_URL']}/forgot-Password");
      Response response = await https.post(url, headers: {'Content-Type': 'application/json'}, body: body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded["status"] == true) {

        return Success(response: response);
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e);
    }
  }

  //getting logged in user
  static Future <Object> getUser(BuildContext context)async{
    try{
      String userId = await UserPreferences().getUserId();
      String token = await UserPreferences().getToken();
      var url = Uri.parse("${dotenv.env['BASE_URL']}/get-user?authId=$userId");

      var response = await https.get(url, headers: {'authorization': token});
      final Map<String,dynamic> responseData = json.decode(response.body);
      if (responseData["status"] == true) {
        var userData = responseData['data'];
        NewUser authUser = NewUser.fromJson(userData);
        Provider.of<UserProvider>(context, listen: false).setUser(authUser);

        return Success(response: authUser);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: responseData["message"]);
    }on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    }on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid format");
    }on SocketException {
        return Failure(code: NO_INTERNET, errorResponse: "No internet connection");

      } catch(e){
      print(e);
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown error");
    }

  }


  //Register a user
  static Future<Object> validateCode() async {
    try {
      String userId = await UserPreferences().getUserId();
      var body = json.encode({
        'authId':userId,
        'verificationCode':int.parse(otpText!),
      });

      var url = Uri.parse("${dotenv.env['BASE_URL']}/verify-auth-code");
      Response response = await https.post(url, headers: {'Content-Type': 'application/json'}, body: body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {
         print("dhjwehwe");
        return Success(response: response);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");

    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e);
    }
  }

  //for sending code to emails
  static Future<Object> sendEmail()async{
    try {
      String userId = await UserPreferences().getUserId();
      var result = await UserPreferences().getUser();

      var url = Uri.parse("${dotenv.env['BASE_URL']}/resend-code");

      Map<String, String> headers = {
        "Content-type": "application/json",
        "authorization": "${dotenv.env['SECRETE']}"

      };

      var body = json.encode({
        "authId":userId,
        "phoneNumber":result.phoneNumber,
        "email":result.email
      });
// make POST request
      Response response = await post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return Success(response: response);

      }

      throw Failure(code: USER_INVALID_RESPONSE, errorResponse: "Sorry error occurred");
    }on HttpException{
      throw Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    }on FormatException{
      throw Failure(code: INVALID_FORMAT, errorResponse: "Invalid format");
    }on SocketException {
      throw Exception("No internet connection");
    } catch(e){
      throw Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown error");

    }}
}