import 'package:db_finalproject/core/services/ApiService.dart';
import 'package:db_finalproject/data/Judge.dart';
import 'package:flutter/material.dart';

class JudgeService {
  ApiService _apiService = ApiService();

  Future<void> addJudge(Judge judge) async{
     final response = _apiService.post('/Judge/add', judge.toJson());
  }
}