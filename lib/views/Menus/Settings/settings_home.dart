import 'package:brillo_connetz_app/components/appbar.dart';
import 'package:brillo_connetz_app/components/constants.dart';
import 'package:brillo_connetz_app/components/modalProgressFunction.dart';
import 'package:brillo_connetz_app/components/sms_buttons.dart';
import 'package:brillo_connetz_app/services/logout.dart';
import 'package:brillo_connetz_app/utility/colors.dart';
import 'package:brillo_connetz_app/utility/dimen.dart';
import 'package:brillo_connetz_app/utility/routes.dart';
import 'package:brillo_connetz_app/view_model/profile_view_modal.dart';
import 'package:brillo_connetz_app/views/Menus/Settings/email.dart';
import 'package:brillo_connetz_app/views/Menus/Settings/username.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
class SettingsHomeScreen extends StatefulWidget {
  const SettingsHomeScreen({Key? key}) : super(key: key);

  @override
  _SettingsHomeScreenState createState() => _SettingsHomeScreenState();
}

class _SettingsHomeScreenState extends State<SettingsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    ChangeNotifierProvider<ProfileViewModal>(
        create: (context)=> ProfileViewModal(),
    builder: (context,child){

    return Consumer<ProfileViewModal>(
    builder: (context, modal, child){


    return Scaffold(
        appBar: const GeneralAppbar(title: "Settings & Privacy", color: kOrangeColor,),
        body: ProgressHUDFunction(
          inAsyncCall: modal.loading,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: kMargin),
      child: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const UpdateUsernameScreen()));

              },
              child: Text("Change username",
                  style: Theme.of(context).textTheme.headline2!.copyWith(color: kLightBlue)
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

            InkWell(
              onTap: (){
                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const UpdateEmailScreen()));

              },
              child: Text("Change Email",
                  style: Theme.of(context).textTheme.headline2!.copyWith(color: kLightBlue)
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

            InkWell(
              onTap: (){
                verifyEmailForgotPassword(context);
              },
              child: Text("Change Password",
                  style: Theme.of(context).textTheme.headline2!.copyWith(color: kLightBlue)
              ),
            ),
            spacing(context),
            spacing(context),
            GButtons(title: "Logout", color: kRedColor, tapSmsButton: ()=>LogOutUser().logoutUser(context)),
            spacing(context),
            GButtons(title: "Delete Account", color: kRedColor, tapSmsButton: ()=>modal.getDeleteAccount(context)),
            spacing(context),


          ],
      ),
    ),
        ));
        });
    }));
        }
}


