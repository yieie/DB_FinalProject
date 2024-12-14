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

  Map<String, dynamic> toJson(){
    return {
      'id':id,
      'passwd': passwd,
      'name': name,
      'email': email,
      'sexual': sexual,
      'phone': phone
    };
  }

  void setField(String field,String value){
    switch (field) {
      case 'id':
        id = value;
        break;
      case 'passwd':
        passwd = value;
        break;
      case 'name':
        name = value;
        break;
      case 'email':
        email = value;
        break;
      case 'sexual':
        sexual = value;
        break;
      case 'phone':
        phone = value;
        break;
      default:
        break;
    }
  }

  String getField(String field){
    switch (field) {
      case 'id':
        return id;
      case 'passwd':
        return passwd!;
      case 'name':
        return name;
      case 'email':
        return email;
      case 'sexual':
        return sexual;
      case 'phone':
        return phone;
      default:
        return '';
    }
  }
}