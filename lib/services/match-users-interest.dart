import 'dart:convert';
import 'dart:io';
import 'package:brillo_connetz_app/models/match_modal.dart';
import 'package:brillo_connetz_app/repos/api_status.dart';
import 'package:brillo_connetz_app/utility/shared_prefrences.dart';
import 'package:brillo_connetz_app/components/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as https;

class MatchApiCaller {


  Future<List<MatchUsersModel>> fetchUsers() async {
    try {
      String userId = await UserPreferences().getUserId();
      String token = await UserPreferences().getToken();
      var result = await UserPreferences().getUser();

      var url = "${dotenv.env['BASE_URL']}/match-user?authId=$userId&page=1&interest=${result.interest}";

      final response = await https.get(Uri.parse(url),headers: {'authorization': token,'Content-Type': 'application/json'},);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);
      if (jsonDecoded['status'] == true) {
        final List<dynamic> responseData = jsonDecoded['data'];

        final product = responseData.map((json) => MatchUsersModel.fromJson(json))
            .toList();
        var _allUsers = <MatchUsersModel>[];
        getUsers.addAll(_allUsers);
        return product;
      }

      throw Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    }on HttpException{
      throw Failure(code: NO_INTERNET, errorResponse: "Internal error server");
    }on FormatException{
      throw Failure(code: INVALID_FORMAT, errorResponse: "Invalid format");
    }on SocketException {
      throw Failure(code: NO_INTERNET, errorResponse: "No internet connection");

    } catch(e){
      throw Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown error");

    }
  }
}