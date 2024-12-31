import 'package:db_finalproject/data/Announcement.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:db_finalproject/core/services/ApiService.dart';
import 'package:http/http.dart';

class AdminAnnService{
  final ApiService _apiService = ApiService();

  Future<void> addAnnouncement(
    Announcement ann,
    List<PlatformFile>? files,
    List<PlatformFile>? imgs
  ) async{
    if(files != null && imgs != null){
      final response = await _apiService.uploadFile(
        '/Ann/add',
        files: files,
        Imgs: imgs,
        additionalData: ann.toJson()
        );
    }else if(files != null){
      final response = await _apiService.uploadFile(
        '/Ann/add',
        files: files,
        additionalData: ann.toJson()
        );
    }else if(imgs !=null){
      final response = await _apiService.uploadFile(
        '/Ann/add',
        Imgs: imgs,
        additionalData: ann.toJson()
        );
    }else{
      final response = await _apiService.uploadFile(
        '/Ann/add',
        additionalData: ann.toJson()
        );
    }
    print('addAnnouncement:');
  }

  Future<void> editAnnouncement(
    Announcement ann,
    List<PlatformFile>? files,
    List<PlatformFile>? imgs
  ) async {
    if(files != null && imgs != null){
      final response = await _apiService.uploadFile(
        '/Ann/edit/${ann.id}',
        files: files,
        Imgs: imgs,
        additionalData: ann.toJson()
        );
    }else if(files != null){
      final response = await _apiService.uploadFile(
        '/Ann/edit/${ann.id}',
        files: files,
        additionalData: ann.toJson()
        );
    }else if(imgs !=null){
      final response = await _apiService.uploadFile(
        '/Ann/edit/${ann.id}',
        Imgs: imgs,
        additionalData: ann.toJson()
        );
    }else{
      final response = await _apiService.uploadFile(
        '/Ann/edit/${ann.id}',
        additionalData: ann.toJson()
        );
    }
  }
}