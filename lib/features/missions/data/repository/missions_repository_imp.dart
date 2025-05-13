import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/missions/data/datasource/missions_data_source.dart';
import 'package:dariwall/features/missions/data/model/mission_model.dart';
import 'package:dariwall/features/missions/data/model/province_model.dart';
import 'package:dariwall/features/missions/data/model/student_info_mission_model.dart';
import 'package:dariwall/features/missions/domain/repository/missions_repository.dart';
import 'package:dio/dio.dart';

class MissionsRepositoryImp extends MissionsRepository {
  MissionsDataSource missionsDataSource;

  MissionsRepositoryImp({required this.missionsDataSource});

  @override
  Future<Either<AppException, void>> studentInfoMission(
      {required StudentInfoMissionModel studentInfo}) async {
    try {
      await missionsDataSource.studentInfoMission(studentInfo);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> followTwitterMission({required MultipartFile imageFile}) async {
    try {
      await missionsDataSource.followTwitterMission(imageFile: imageFile);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> likeTwitterMission({required MultipartFile imageFile}) async {
    try {
      await missionsDataSource.likeTwitterMission(imageFile: imageFile);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> retweetTwitterMission({required MultipartFile imageFile}) async {
    try {
      await missionsDataSource.retweetTwitterMission(imageFile: imageFile);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> commentOnTwitterMission({required MultipartFile imageFile}) async {
    try {
      await missionsDataSource.commentOnTwitterMission(imageFile: imageFile);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> joinTelegramChannelMission() async {
    try {
      await missionsDataSource.joinTelegramChannelMission();
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> joinDiscussionGroupMission() async {
    try {
      await missionsDataSource.joinDiscussionGroupMission();
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> joinDariwallTelegramChannelMission() async {
    try {
      await missionsDataSource.joinDariwallTelegramChannelMission();
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> likeCoinmarketcapMission({required MultipartFile imageFile}) async {
    try {
      await missionsDataSource.likeCoinmarketcapMission(imageFile: imageFile);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> likeCoinGeckoMission({required MultipartFile imageFile}) async {
    try {
      await missionsDataSource.likeCoinGeckoMission(imageFile: imageFile);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, List<ProvinceModel>>> getProvinces() async {
    try {
      final List<ProvinceModel> provinces = await missionsDataSource.getProvinces();
      return Right(provinces);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, List<MissionModel>>> getMissions() async {
    try {
      final List<MissionModel> missions = await missionsDataSource.getMissions();
      return Right(missions);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
