import 'package:db_finalproject/core/services/ApiService.dart';
import 'package:db_finalproject/data/Student.dart';
import 'package:db_finalproject/data/Teacher.dart';
import 'package:db_finalproject/data/User.dart';
import 'package:db_finalproject/data/Judge.dart';

class PersonalDataService {
  final ApiService _apiService = ApiService();

  //獲取使用者的詳細資料
  Future<User> getUserData(String usertype, String useraccount) async{
    usertype = usertype[0].toUpperCase() + usertype.substring(1);
    // final response = await _apiService.post('/$usertype/detailsData', {'${usertype}ID': useraccount});
    final response = await _apiService.get('/$usertype/detailsData/$useraccount');
    if(usertype == 'Stu'){
      return Student.fromJson(response);
    }else if(usertype == 'Tr'){
      return Teacher.fromJson(response);
    }else if(usertype == 'Judge'){
      return Judge.fromJson(response);
    }else{
      throw Exception('usertype錯誤');
    }
  }

  //更新使用者資料
  Future<void> updateUserData(String usertype, User user) async{
    //第一個字母大寫(Stu Tr Judge)
    usertype = usertype[0].toUpperCase() + usertype.substring(1);
    await _apiService.post('/$usertype/${user.id}/update', user.toJson());
  }
}