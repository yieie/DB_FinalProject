import 'package:db_finalproject/core/services/ApiService.dart';
import 'package:db_finalproject/data/Workshop.dart';

class StuWorkshopservice {
  final ApiService _apiService = ApiService();

  //路徑再自己改一下!

  //拿所有工作坊的資料，需要工作坊id、日期、時間、主題、演講者姓名、頭銜
  Future<List<Workshop>> getAllWorkshop() async{
    final response = await _apiService.get('/Workshop/get');
    return (response as List).map((json) => Workshop.fromJson(json)).toList();
  }


  //學生報名工作坊，送學生id到後端
  Future<void> registerWorkshop(int wsid,String stuid) async{
    await _apiService.post('/Workshop/$wsid', {'stuid': stuid});
  }
}