class User{
  String id;
  String? passwd;
  String name;
  String email;
  String sexual;
  String phone;

  User({
    required this.id,
    this.passwd,
    required this.name,
    required this.email,
    required this.sexual,
    required this.phone
  });
}