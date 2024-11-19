import 'user.dart';

class UserData {
  User? user;
  String? token;

  UserData({
    this.user,
    this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
      };
}
