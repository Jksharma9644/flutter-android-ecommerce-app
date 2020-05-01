
class ProfileData {

  final int id ;
  final String name;
  final String email;
  final String mobilenumber;
  final List address;
  final bool isMobileVerified;

  ProfileData({this.id, this.name,this .email, this.mobilenumber, this.address, this .isMobileVerified});

  factory ProfileData.fromJson(Map<String,dynamic> parsedJson){
    return ProfileData(
      id: parsedJson['_id'],
      email:parsedJson['email'],
      name: parsedJson['username'],
      mobilenumber: parsedJson['isNumberVerified'],
       isMobileVerified: parsedJson['address'],
       address:parsedJson['address']
    );
  }


}

