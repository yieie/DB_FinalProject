import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/Announcement.dart';
import 'package:db_finalproject/core/services/ApiService.dart';


class AnnouncementRepository {
  final ApiService _apiService = ApiService();

  Future<List<Announcement>> fetchBasicAnnouncement() async {
    final response = await _apiService.get('/Ann/list');
    return (response as List)
    .map((json) => Announcement.fromJson(json))
    .toList();
  }

  Future<Announcement> fetchDetailAnnouncement(int id) async{
    final response = await _apiService.get('/Ann/details/$id');
    return Announcement.fromJson(response);
  }

}