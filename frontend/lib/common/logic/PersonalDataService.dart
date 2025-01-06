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
      return Student(
        id: useraccount, 
        passwd: response['stupasswd'] as String,
        name: response['stuname'] as String, 
        email: response['stuemail'] as String, 
        sexual: response['stusexual'] as String, 
        phone: response['stuphone'] as String, 
        major: response['stumajor'] as String, 
        grade: response['stugrade'] as String,
        isLeader: response['stuisLeader'] as bool?,
        teamid: response['teamid'] as String?,
        stuIdCard: response['stuIdCard'] as String?
      );
    }else if(usertype == 'Tr'){
      return Teacher(
        id: useraccount, 
        passwd: response['trpasswd'] as String,
        name: response['trname'] as String, 
        email: response['trid'] as String, //在資料庫裏面email只存在id欄位，在前端為了方便呼叫會多email欄位
        sexual: response['trsexual'] as String, 
        phone: response['trphone'] as String,
        trJobType: response['trjobtype'] as String?,
        trDepartment: response['trdepartment'] as String?,
        trOriganization: response['trorganization'] as String?
      );
    }else if(usertype == 'Judge'){
      return Judge(
      id: useraccount,
      passwd: response['judgepasswd'],
      name: response['judgename'] as String, 
      email: response['judgeemail'] as String, 
      sexual: response['judgesexual'] as String, 
      phone: response['judgephone'] as String,
      title: response['judgetitle'] as String?
    );
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