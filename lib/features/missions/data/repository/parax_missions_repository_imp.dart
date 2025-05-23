import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dariwall/features/missions/data/datasource/parax_missions_data_source.dart';
import 'package:dariwall/features/missions/domain/repository/parax_missions_repository.dart';
import 'package:dio/dio.dart';

class ParaxMissionsRepositoryImp extends ParaxMissionRepository {
  final ParaxMissionsDataSource paraxMissionsDataSource;

  ParaxMissionsRepositoryImp({required this.paraxMissionsDataSource});

  @override
  Future<Either<AppException, void>> checkJoinParaxTelegramChannel() async {
    try {
      await paraxMissionsDataSource.checkJoinParaxTelegramChannel();
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> commentOnParaxTwitterPost(
      {required MultipartFile imageFile}) async {
    try {
      await paraxMissionsDataSource.commentOnParaxTwitterPost(imageFile: imageFile);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> followParaxInTwitter(
      {required MultipartFile imageFile}) async {
    try {
      await paraxMissionsDataSource.followParaxInTwitter(imageFile: imageFile);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> likeParaxTwitterPost(
      {required MultipartFile imageFile}) async {
    try {
      await paraxMissionsDataSource.likeParaxTwitterPost(imageFile: imageFile);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> retweetParaxTwitterPost(
      {required MultipartFile imageFile}) async {
    try {
      await paraxMissionsDataSource.retweetParaxTwitterPost(imageFile: imageFile);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> likeParaxInCoinmarketcap(
      {required MultipartFile imageFile}) async {
    try {
      await paraxMissionsDataSource.likeParaxInCoinmarketcap(imageFile: imageFile);
      return Right(null);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
