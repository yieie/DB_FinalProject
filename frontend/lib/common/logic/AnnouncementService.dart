import 'package:db_finalproject/data/Announcement.dart';
import 'package:db_finalproject/common/data/AnnouncementRepository.dart';

class AnnouncementService {
  final AnnouncementRepository _repository = AnnouncementRepository();

  Future<List<Announcement>> getBasicAnnouncement(){
    return _repository.fetchBasicAnnouncement();
  }

  Future<Announcement> getDetailAnnouncemnet(int id){
    return _repository.fetchDetailAnnouncement(id);
  }
}