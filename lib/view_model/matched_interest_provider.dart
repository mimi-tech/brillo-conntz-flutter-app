import 'package:brillo_connetz_app/components/constants.dart';
import 'package:brillo_connetz_app/models/match_modal.dart';
import 'package:brillo_connetz_app/services/match-users-interest.dart';
import 'package:flutter/foundation.dart';

class MatchingUsersProvider with ChangeNotifier {
  bool _loading = false;
  var _allUsers = <MatchUsersModel>[];

  bool get loading => _loading;
  List<MatchUsersModel> get allUsers => _allUsers;


  setLoading(bool loading) async {
    _loading = loading;
    //notifyListeners();
  }

  setAllUsers(List<MatchUsersModel> allUsers) {
    _allUsers = allUsers;
  }


getProducts() async {
  setLoading(true);
  var response = await MatchApiCaller().fetchUsers();
  if (response.isNotEmpty) {
     setAllUsers(response);

    setLoading(false);

  }else{
    setLoading(false);
    notifyFlutterToastError(title:"Sorry error occurred");
  }
}}