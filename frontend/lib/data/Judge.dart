import 'package:db_finalproject/data/User.dart';

class Judge extends User{
  String? title;

  Judge({
    required super.id,
    super.passwd,
    required super.name,
    required super.email,
    required super.sexual,
    required super.phone,
    this.title
  });
}