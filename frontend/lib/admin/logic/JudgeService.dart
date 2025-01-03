import 'package:db_finalproject/core/services/ApiService.dart';
import 'package:db_finalproject/data/Judge.dart';
import 'package:flutter/material.dart';

class JudgeService {
  ApiService _apiService = ApiService();

  //送新增judge request到後端，包含姓名、性別、email(即id)、電話、頭銜
  Future<void> addJudge(Judge judge) async{
     final response = _apiService.post('/Judge/add', judge.toJson());
  }
}