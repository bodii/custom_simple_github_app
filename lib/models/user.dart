class User {
  final String username;
  final String password;

  const User(this.username, this.password);

  factory User.fromJson(Map<String, dynamic> json) =>
      User(json['username'], json['password']);

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
