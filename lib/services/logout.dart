import 'package:brillo_connetz_app/utility/routes.dart';
import 'package:brillo_connetz_app/utility/shared_prefrences.dart';

class LogOutUser{
   logoutUser(context) {
    UserPreferences().removeUser();
    loginScreen(context);
  }
}