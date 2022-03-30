
class UserModel{
  String ? firstName;
  String ? lastName;
  String ? phone;
  String ? address;
  String ? dateOfBirth;
  String ? image ;
  String ? uid;
  String ? bio;
  String ? token;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.dateOfBirth,
    this.token,
    this.image,
    this.bio,
    this.uid});

  UserModel.fromJson(Map<String, dynamic> json){
    firstName = json ['firstName'];
    lastName = json ['lastName'];
    phone = json ['phone'];
    address = json ['address'];
    image = json ['image'];
    uid = json ['uid'];
    dateOfBirth= json['dateOfBirth'];
    bio =json['bio'];
    token = json['token'];
  }

  Map<String, dynamic> toMap(){
    return {
      'firstName':firstName,
      'lastName':lastName,
      'phone':phone,
      'address':address,
      'image':image,
      'uid':uid,
      'dateOfBirth':dateOfBirth,
      'bio':bio,
      'token':token,
    };
  }
}