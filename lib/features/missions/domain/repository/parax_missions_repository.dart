import 'package:dariwall/core/models/either.dart';
import 'package:dariwall/core/services/error_handler_service.dart';
import 'package:dio/dio.dart';

abstract class ParaxMissionRepository {
  Future<Either<AppException, void>> followParaxInTwitter({required MultipartFile imageFile});
  Future<Either<AppException, void>> likeParaxTwitterPost({required MultipartFile imageFile});
  Future<Either<AppException, void>> retweetParaxTwitterPost({required MultipartFile imageFile});
  Future<Either<AppException, void>> commentOnParaxTwitterPost({required MultipartFile imageFile});
  Future<Either<AppException, void>> likeParaxInCoinmarketcap({required MultipartFile imageFile});
  Future<Either<AppException, void>> checkJoinParaxTelegramChannel();
}
