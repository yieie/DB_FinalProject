import 'package:db_finalproject/data/Workshop.dart';
import 'package:db_finalproject/core/services/ApiService.dart';

class WorkshopService{
  final ApiService _apiService = ApiService();

  //獲取Workshop資訊
  Future<Workshop> getWorkshop(String id) async{
    final response = await _apiService.get('/Workshop/$id');
    return Workshop.fromJson(response);
  }

  //新增Workshop
  Future<bool> addWorkshop(Workshop workshop) async{
    return await _apiService.post('/Workshop/add', workshop.toJson());
  }

  //編輯Workshop
  Future<bool> editWorkshop(Workshop workshop) async{
    return await _apiService.put('/Workshop/edit/${workshop.wsid}', workshop.toJson());
  }
}