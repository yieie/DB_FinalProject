import 'package:db_finalproject/features/admin/data/TeamsStatus.dart';
import 'package:db_finalproject/features/admin/data/TeamsStatusRepository.dart';

class TeamsStatusService {
  final TeamsStatusRepository _teamsStatusRepository = TeamsStatusRepository();

  Future<TeamsStatus> getTeamsStatus(){
    return _teamsStatusRepository.fetchTeamsStatus();
  }
}