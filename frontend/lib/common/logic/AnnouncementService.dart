import 'package:db_finalproject/data/Announcement.dart';
import 'package:db_finalproject/core/services/ApiService.dart';

class AnnouncementService {
  final ApiService _apiService = ApiService();

  Future<List<Announcement>> getBasicAnnouncement() async{
    final response = await _apiService.get('/Ann/list');
    return (response as List)
    .map((json) => Announcement.fromJson(json))
    .toList();
  }

  Future<Announcement> getDetailAnnouncemnet(int id) async{
    final response = await _apiService.get('/Ann/details/$id');
    return Announcement.fromJson(response);
  }
}