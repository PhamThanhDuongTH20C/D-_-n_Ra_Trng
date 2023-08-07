class Users {
  var status;
  var id;
  String name;
  String email;
  var accessToken;
  var group_role;
  var is_active;
  var password;
  var password_confirm;
  Users({
    required this.status,
    required this.id,
    required this.name,
    required this.email,
    required this.accessToken,
    required this.group_role,
    required this.is_active,
    required this.password_confirm,
    required this.password,
  });
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        is_active: json['is_active'] ?? '',
        group_role: json['group_role'] ?? '',
        status: json['status'] ?? '',
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        accessToken: json['access_token'] ?? '',
        password: json['password'] ?? '',
        password_confirm: json['password_confirm'] ?? '');
  }
}
