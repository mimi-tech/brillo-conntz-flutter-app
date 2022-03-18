class MatchUsersModel {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? username;
  String? profileImageUrl;
  String? interest;



  MatchUsersModel({

    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.username,
    this.profileImageUrl,
    this.interest,


  });

  // now create converter

  factory MatchUsersModel.fromJson(Map<String,dynamic> responseData){
    return MatchUsersModel(
      firstName: responseData['firstName'],
      phoneNumber: responseData['phoneNumber'],
      lastName: responseData['lastName'],
      username: responseData['username'],
      profileImageUrl: responseData['profileImageUrl'],
      interest: responseData['interest'],

    );
  }
  Map<String, dynamic> toJson() {
    return {
      "fullName": firstName,
      "phoneNumber": phoneNumber,
      "lastName": lastName,
      "username": username,
      "profileImageUrl": profileImageUrl,
      "interest": interest,
    };
  }
}