import 'package:db_finalproject/core/services/ApiService.dart';
import 'package:db_finalproject/data/Judge.dart';

class JudgeService {
  final ApiService _apiService = ApiService();

  //拿所有judge資料，全部都要(除了passwd)
  Future<List<Judge>> getAllJudge() async{
    final response = await _apiService.get('/Judge');
    return (response as List).map((json) => Judge.fromJson(json)).toList();
  }

  //送新增judge request到後端，包含姓名、性別、email(即id)、電話、頭銜
  Future<void> addJudge(Judge judge) async{
     await _apiService.post('/Judge/add', judge.toJson());
  }
}