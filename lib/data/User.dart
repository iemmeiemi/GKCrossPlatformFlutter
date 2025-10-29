
class User {
  String id;
  String username;
  String password;
  String email;
  String image;

  User( {required this.id, required this.username, required this.password, required this.email, required this.image} );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'image': image,
    };
  }

  factory User.fromJson(Map<String, dynamic> json, String id) {
    return User(
      id: id,
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? 0,
    );
  }

}