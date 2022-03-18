
import 'dart:io';

import 'package:brillo_connetz_app/components/constants.dart';
import 'package:brillo_connetz_app/models/new_user.dart';
import 'package:brillo_connetz_app/repos/api_status.dart';
import 'package:brillo_connetz_app/services/auth_services.dart';
import 'package:brillo_connetz_app/utility/routes.dart';
import 'package:brillo_connetz_app/utility/shared_prefrences.dart';
import 'package:brillo_connetz_app/view_model/users_Auth_provider.dart';
import 'package:brillo_connetz_app/views/otp_screen.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {

  File? imageFile;
  bool _loading  = false;


  bool get loading => _loading;


  setLoading(bool loading) async{
    _loading = loading;
    notifyListeners();
  }
//this functions is for login
   getLogin(BuildContext context) async {

    setLoading(true);
    var response = await AuthServices.loginUser(context);
    if (response is Success) {
      setLoading(false);
      bottomBar(context);
    }
    if(response is Failure){
      setLoading(false);
      notifyFlutterToastError(title: "${response.errorResponse}");
    }

  }
//this functions is validates if the user verification code
  verifyAuthCode(BuildContext context) async {
    setLoading(true);

    var response = await AuthServices.validateCode();
    if (response is Success) {
      //authenticate the user
      await getLogin(context);
    }
    if(response is Failure){
      setLoading(false);
      notifyFlutterToastError(title: "${response.errorResponse}");
    }
  }

//this functions is for registration
 userRegistration(BuildContext context) async {

   try{
     setLoading(true);
     var response = await AuthServices.registerUser();
     if (response is Success) {
       setLoading(false);
       //push the user to the screen where the user can enter the code sent to his phone number and email
       Navigator.pushAndRemoveUntil(context,
         MaterialPageRoute(
           builder: (BuildContext context) => RequestForOTP(),
         ),
             (route) => false,
       );
     }
     if(response is Failure){
       setLoading(false);
       notifyFlutterToastError(title: "${response.errorResponse}");
     }
   }catch(e){
     setLoading(false);
     return notifyFlutterToastError(title: "Login not successful");

   }}




  //reset password services


  resetPassword(BuildContext context) async {

    try{
      setLoading(true);
      var response = await AuthServices.resetPassword();
      if (response is Success) {
        setLoading(false);
        loginScreen(context);
        notifyFlutterToastSuccess(title: AppLocalizations.of(context)!.successful);

      }
      if(response is Failure){
        setLoading(false);
        notifyFlutterToastError(title: "${response.errorResponse}");
      }
    }catch(e){
      setLoading(false);
      return notifyFlutterToastError(title: "Login not successful");

    }}

//this functions fetches the details of current user
    getLoggedInUserDetails(BuildContext context) async {
        var response = await AuthServices.getUser(context);
        if (response is Success) {
//do something here
        }
        if(response is Failure){

          notifyFlutterToastError(title: "${response.errorResponse}");
        }


  }

//this functions fetches the details of current user with validation
  getLoggedInUserIsVerified(BuildContext context) async {
    var response = await AuthServices.getUser(context);
    if (response is Success) {
      //check if users has verified its account
      var result = await UserPreferences().getUser();

      if(result.isAccountVerified == false){
        //push the user to verification screen
        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: RequestForOTP()));

      }else{
        //push the user to home screen
        bottomBar(context);
      }

    }
    if(response is Failure){

      notifyFlutterToastError(title: "${response.errorResponse}");
    }


  }

  getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final cloudinary = CloudinaryPublic('${dotenv.env['CLOUDINARY_NAME']}', '${dotenv.env['CLOUDINARY_PRESET']}', cache: false);


    try {
      notifyFlutterToastSuccess(title: "Image Uploading...");
      setLoading(true);

      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          pickedFile!.path,
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      profileImageUrl = response.secureUrl;
      notifyFlutterToastSuccess(title: "Uploaded successfully");
      setLoading(false);
      // ignore: unused_catch_clause
    } catch (e) {
      setLoading(false);
      notifyFlutterToastError(title: "Error uploading your product image");
    }

    imageFile = File(pickedFile!.path);


  }

  //this functions is resending  verification code to both email and phoneNumber
  getResendService() async {
    setLoading(true);

    var response = await AuthServices.sendEmail();
    if (response is Success) {

      notifyFlutterToastSuccess(title: "Code sent successfully");

    }
    if(response is Failure){
      setLoading(false);
      notifyFlutterToastError(title: "${response.errorResponse}");
    }
  }

}

