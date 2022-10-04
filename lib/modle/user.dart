class UserApp {
  String? id;
  String? name;
  String? email;
  String? password;

  UserApp(
      {this.id,
        required this.name,
        required this.email,
        required this.password});
  UserApp.fromMap(Map map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    password = map['password'];
  }
  toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password
    };
  }
}
