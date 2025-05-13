import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/missions/data/model/mission_model.dart';
import 'package:dariwall/features/missions/data/model/province_model.dart';
import 'package:dariwall/features/missions/data/model/student_info_mission_model.dart';
import 'package:dio/dio.dart';

abstract class MissionsRepository {
  Future<Either<AppException, void>> studentInfoMission(
      {required StudentInfoMissionModel studentInfo});
  Future<Either<AppException, void>> followTwitterMission({required MultipartFile imageFile});
  Future<Either<AppException, void>> likeTwitterMission({required MultipartFile imageFile});
  Future<Either<AppException, void>> retweetTwitterMission({required MultipartFile imageFile});
  Future<Either<AppException, void>> commentOnTwitterMission({required MultipartFile imageFile});
  Future<Either<AppException, void>> joinTelegramChannelMission();
  Future<Either<AppException, void>> joinDiscussionGroupMission();
  Future<Either<AppException, void>> joinDariwallTelegramChannelMission();
  Future<Either<AppException, void>> likeCoinmarketcapMission({required MultipartFile imageFile});
  Future<Either<AppException, void>> likeCoinGeckoMission({required MultipartFile imageFile});
  Future<Either<AppException, List<ProvinceModel>>> getProvinces();
  Future<Either<AppException, List<MissionModel>>> getMissions();
}
