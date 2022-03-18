class NewUser {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? username;
  String? profileImageUrl;
  String? interest;
  bool?   isAccountVerified;


  NewUser({
     this.userId,
     this.firstName,
     this.lastName,
     this.email,
     this.phoneNumber,
     this.username,
     this.profileImageUrl,
     this.interest,
     this.isAccountVerified,


  });

  // now create converter

  factory NewUser.fromJson(Map<String,dynamic> responseData){
    return NewUser(
      userId: responseData['_id'],
      firstName: responseData['firstName'],
      email : responseData['email'],
      phoneNumber: responseData['phoneNumber'],
      lastName: responseData['lastName'],
      username: responseData['username'],
      profileImageUrl: responseData['profileImageUrl'],
      interest: responseData['interest'],
        isAccountVerified: responseData['isAccountVerified'],

    );
  }
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "fullName": firstName,
      "email": email,
      "phoneNumber": phoneNumber,
      "lastName": lastName,
      "username": username,
      "profileImageUrl": profileImageUrl,
      "interest": interest,
      "isAccountVerified":isAccountVerified,
    };
  }
}