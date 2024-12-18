import 'package:db_finalproject/features/common/data/Announcement.dart';
import 'package:db_finalproject/features/common/data/AnnouncementRepository.dart';

class AnnouncementService {
  final AnnouncementRepository _repository = AnnouncementRepository();

  Future<List<Announcement>> getBasicAnnouncement(){
    return _repository.fetchBasicAnnouncement();
  }

  Future<Announcement> getDetailAnnpuncemnet(int id){
    return _repository.fetchDetailAnnouncement(id);
  }
}