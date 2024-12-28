import 'package:db_finalproject/data/TeamsStatus.dart';
import 'package:db_finalproject/core/services/ApiService.dart';
class TeamsStatusService {
  final ApiService _apiService = ApiService();

  Future<TeamsStatus> getTeamsStatus() async{
    final response = await _apiService.get('/Teams/Status');
    return TeamsStatus.fromJson(response);
  }
}