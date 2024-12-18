import 'package:db_finalproject/features/common/data/User.dart';

class Judge extends User{
  String? jTitle;

  Judge({
    required super.id,
    super.passwd,
    required super.name,
    required super.email,
    required super.sexual,
    required super.phone,
    this.jTitle
  });
}