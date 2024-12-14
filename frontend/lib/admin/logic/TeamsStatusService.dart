import 'package:db_finalproject/data/TeamsStatus.dart';
import 'package:db_finalproject/core/services/ApiService.dart';
class TeamsStatusService {
  final ApiService _apiService = ApiService();
  //待審核報名、需補件、已補件、待審核初賽資格、初賽隊伍、決賽隊伍
  //拿所有隊伍狀態，已報名、待審核、已審核、需補件、待補件的隊伍數
  Future<TeamsStatus> getTeamsStatus() async{
    final response = await _apiService.get('/Teams/Status');
    return TeamsStatus.fromJson(response);
  }
}