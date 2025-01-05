import 'package:db_finalproject/data/Announcement.dart';
import 'package:file_picker/file_picker.dart';
import 'package:db_finalproject/core/services/ApiService.dart';

class AdminAnnService{
  final ApiService _apiService = ApiService();

  //新增公告，包含所有檔案、照片、ann詳細資料(id預設為-1、info、admin)
  Future<void> addAnnouncement(
    Announcement ann,
    List<PlatformFile>? files,
    List<PlatformFile>? imgs
  ) async{
    if(files != null && imgs != null){
      await _apiService.uploadFile(
        '/Ann/add',
        files: files,
        Imgs: imgs,
        additionalData: ann.toJson()
        );
    }else if(files != null){
      await _apiService.uploadFile(
        '/Ann/add',
        files: files,
        additionalData: ann.toJson()
        );
    }else if(imgs !=null){
      await _apiService.uploadFile(
        '/Ann/add',
        Imgs: imgs,
        additionalData: ann.toJson()
        );
    }else{
      await _apiService.uploadFile(
        '/Ann/add',
        additionalData: ann.toJson()
        );
    }
    print('addAnnouncement:');
  }

  //修改公告，包含所有檔案、照片、Ann的詳細資料(id、info、admin)
  Future<void> editAnnouncement(
    Announcement ann,
    List<PlatformFile>? files,
    List<PlatformFile>? imgs
  ) async {
    if(files != null && imgs != null){
      await _apiService.uploadFile(
        '/Ann/edit/${ann.id}',
        files: files,
        Imgs: imgs,
        additionalData: ann.toJson()
        );
    }else if(files != null){
      await _apiService.uploadFile(
        '/Ann/edit/${ann.id}',
        files: files,
        additionalData: ann.toJson()
        );
    }else if(imgs !=null){
      await _apiService.uploadFile(
        '/Ann/edit/${ann.id}',
        Imgs: imgs,
        additionalData: ann.toJson()
        );
    }else{
      await _apiService.uploadFile(
        '/Ann/edit/${ann.id}',
        additionalData: ann.toJson()
        );
    }
  }
}