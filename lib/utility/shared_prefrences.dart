
import 'package:brillo_connetz_app/models/new_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

//THIS FUNCTIONS saves the users details in a shared preference
  Future<bool> saveUser(NewUser user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userId',user.userId ?? "");
    prefs.setString('firstName',user.firstName ?? "");
    prefs.setString('lastName',user.lastName ?? "");
    prefs.setString('email',user.email ?? "");
    prefs.setString('phoneNumber',user.phoneNumber ?? "");
    prefs.setString('username',user.username ?? "");
    prefs.setString('profileImageUrl',user.profileImageUrl ?? "");
    prefs.setString('interest',user.interest ?? "");
    prefs.setBool('isAccountVerified',user.isAccountVerified ?? false);


    return prefs.commit();

  }



  //THIS FUNCTIONS fetches the users details and save it in the model
  Future<NewUser> getUser ()  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString("userId") ?? "";
    String firstName = prefs.getString("firstName") ?? "";
    String lastName = prefs.getString("lastName") ?? "";
    String email = prefs.getString("email") ?? "";
    String phoneNumber = prefs.getString("phoneNumber") ?? "";
    String username = prefs.getString("username") ?? "";
    String profileImageUrl = prefs.getString("profileImageUrl") ?? "";
    String interest = prefs.getString("interest") ?? "";
    bool isAccountVerified = prefs.getBool("isAccountVerified") ?? false;

    return NewUser(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        username: username,
        profileImageUrl:profileImageUrl,
        interest:interest,
        isAccountVerified:isAccountVerified

    );

  }


//THIS FUNCTIONS saves the users token when called
  void saveToken(String token)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token',token);
  }

//THIS FUNCTIONS saves the users authId when called
  void saveAuthId(String userId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId',userId);
  }

  void removeUser() async {
//THIS FUNCTIONS removes the users details from the phone when logged out
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('userId');
    prefs.remove('firstName');
    prefs.remove('lastName');
    prefs.remove('email');
    prefs.remove('phoneNumber');
    prefs.remove('interest');
    prefs.remove('username');
    prefs.remove('profileImageUrl');
    prefs.remove('token');
    prefs.remove('isAccountVerified');



  }
//THIS FUNCTIONS fetches the users token when called
  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    return token;
  }

//THIS FUNCTIONS fetches the users authid when called
  Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("userId") ?? "";
    return userId;
  }

}