
import 'package:brillo_connetz_app/components/constants.dart';
import 'package:brillo_connetz_app/repos/api_status.dart';
import 'package:brillo_connetz_app/services/logout.dart';
import 'package:brillo_connetz_app/services/profile_services.dart';
import 'package:brillo_connetz_app/utility/routes.dart';
import 'package:brillo_connetz_app/utility/shared_prefrences.dart';
import 'package:brillo_connetz_app/view_model/account_provider.dart';
import 'package:brillo_connetz_app/views/Menus/Settings/not_a_user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';

class ProfileViewModal extends ChangeNotifier{
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  getUpdateUsername(context) async{

      setLoading(true);
      var response = await ProfileServices.updateUserName();
      if( response is Success ){
        AuthProvider().getLoggedInUserDetails(context);
        setLoading(false);
        notifyFlutterToastSuccess(title: "User name updated successful");

      }
      if(response is Failure) {
        setLoading(false);
        notifyFlutterToastError(title: "${response.errorResponse}");

      }


  }







  verifyUserEmailCode(context) async {

        setLoading(true);
        //update the user phone number
        var response = await ProfileServices.updateEmailAddress();
        if( response is Success ){

          setLoading(false);
          notifyFlutterToastSuccess(title: "Email address updated successful");


        }
        if(response is Failure) {
          setLoading(false);
          notifyFlutterToastError(title: "${response.errorResponse}");

        }


  }

  getDeleteAccount(context) async {

    setLoading(true);
    //update the user phone number
    var response = await ProfileServices.deletedAccount();
    if( response is Success ){


      notifyFlutterToastSuccess(title: "Account deleted successful");
      Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(
          builder: (BuildContext context) => const NotAUserScreen(),
        ),
            (route) => false,
      );
      //Remove the user details from storage
      UserPreferences().removeUser();
      setLoading(false);
    }
    if(response is Failure) {
      setLoading(false);
      notifyFlutterToastError(title: "${response.errorResponse}");

    }


  }

}

