class UserModel
{
  String ? id;
  String ? userPhone;
  String ? userImageUrl;
  String ? userName;
  String ? userEmail;
  int ? userRate;


  UserModel.fromJson(Map<String , dynamic> json)
  {
    id = json["id"];
    userPhone = json["userPhone"];
    userImageUrl = json["userImageUrl"];
    userName = json["userName"];
    userEmail = json["userEmail"];
    userRate = json["userRate"];
  }
}