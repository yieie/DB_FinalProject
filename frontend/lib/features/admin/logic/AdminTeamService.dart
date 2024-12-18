import 'package:db_finalproject/features/common/data/TeamRepository.dart';
import 'package:db_finalproject/features/common/data/Team.dart';

class AdminTeamService {
  final TeamRepository _teamRepository = TeamRepository();

  Future<List<Team>> getBasicAllTeam(){
    return _teamRepository.fetchBasicAllTeam();
  }
}