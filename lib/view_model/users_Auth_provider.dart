
import 'package:brillo_connetz_app/models/new_user.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  NewUser _user = new NewUser();
  NewUser get user => _user;

  void setUser(NewUser user) {
    _user = user;
    notifyListeners();
  }



}

