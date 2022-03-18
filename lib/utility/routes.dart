import 'package:brillo_connetz_app/components/bottomNavigationBar.dart';
import 'package:brillo_connetz_app/views/Menus/LandingPage.dart';
import 'package:brillo_connetz_app/views/Registration/password_screen.dart';
import 'package:brillo_connetz_app/views/Registration/signup_screen.dart';
import 'package:brillo_connetz_app/views/forgotPassword/change_password.dart';
import 'package:brillo_connetz_app/views/forgotPassword/verify_email.dart';
import 'package:brillo_connetz_app/views/login.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void signupRoutes(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: SignUpScreen()));

}


void passwordScreen(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PasswordScreen()));

}

void loginScreen(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: LoginScreen()));

}

void landingPage(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: LandingPage()));

}
void bottomBar(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: BasicBottomNavBar()));

}

void verifyEmailForgotPassword(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: VerifyEmailScreen()));

}
void changePasswordScreen(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ChangePassword()));

}


