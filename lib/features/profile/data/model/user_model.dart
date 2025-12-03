class UserModel {
  final String username;
  final String phonenumber;
  final String email;

  UserModel({
    required this.username,
    required this.phonenumber,
    required this.email,
  });

  factory UserModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return UserModel(username: "", phonenumber: "", email: "");
    }
    return UserModel(
      username: map["username"] ?? "",
      phonenumber: map["phonenumber"] ?? "",
      email: map["email"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "phonenumber": phonenumber,
      "email": email,
    };
  }
}
