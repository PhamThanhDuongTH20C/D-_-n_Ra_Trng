class User {
  var status;
  var id;
  var name;
  var email;
  var accessToken;
  var password;
  User({
    required this.status,
    required this.id,
    required this.name,
    required this.email,
    required this.accessToken,
    required this.password,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      status: json['status'] ?? '',
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      accessToken: json['access_token'] ?? '',
      password: json['password'] ?? '',
    );
  }
}
