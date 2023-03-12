
class UserModel{
  String email;
  String? password;
  String username;
  String? token;
  UserModel({required this.email, this.password, required this.username, this.token});
}