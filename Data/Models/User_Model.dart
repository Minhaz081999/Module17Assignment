//  Request Body =>
//  {
//  "status":"success",
//  "data":{"_id":"6942bac5880cc5d30a304aa1",
//  "email":"cba@gmail.com",
//  "firstName":"xlr8",
//  "lastName":"turbo",
//  "mobile":"12365478912",
//  "createdDate":"2025-10-02T06:21:41.011Z"
//  },
//  "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NjYwNjczMzksImRhdGEiOiJjYmFAZ21haWwuY29tIiwiaWF0IjoxNzY1OTgwOTM5fQ.rMEx3MX-CWbPVFVDcHqCqd-QtMLW9Y9R_MV_8WAR7RU"
//  }
//  💡
class UserModel{

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String photo;

  UserModel(
      { required this.id,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.mobile,
        required this.photo
      }
      );
// for setting the values from API's data.......................................
  factory UserModel.fromJson(Map<String,dynamic> jsonData){
    return UserModel(id: jsonData['_id'],
      email: jsonData['email'],
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      mobile: jsonData['mobile'],
      photo: jsonData['mobile'] ?? '',

    );

  }
// for getting the values from variables of class of UserModel .................
  // convert to Map<>
  Map<String,dynamic> toJson(){
    return {
      "_id":id,
      "email":email,
      "firstName":firstName,
      "lastName":lastName,
      "mobile":mobile,
    };
  }
// -------------------------- x ----------------------------
}