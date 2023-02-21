class AuthModel {
  final String? email;
  final String? password;

  AuthModel({
    this.email,
    this.password,
  });

  bool compare(String email, String password){
    return (this.email == email && this.password == password);
  }
}
