import 'package:dio/dio.dart';
import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/core/services/api_client_service.dart';
import 'package:dariwall/features/missions/data/model/mission_model.dart';
import 'package:dariwall/features/missions/data/model/province_model.dart';
import 'package:dariwall/features/missions/data/model/student_info_mission_model.dart';

class MissionsDataSource {
  final ApiClientService _apiClientService;

  MissionsDataSource({
    required ApiClientService apiClientService,
  }) : _apiClientService = apiClientService;

  Future<void> studentInfoMission(StudentInfoMissionModel studentInfo) async {
    final formData = FormData.fromMap(
      {
        AppKeys.keyStudentNumber: studentInfo.studentNumber,
        AppKeys.keyFullName: studentInfo.fullName,
        AppKeys.keyProvinceCode: studentInfo.provinceCode,
        AppKeys.keyUniversityName: studentInfo.universityName,
        AppKeys.keyPhoneNumber: studentInfo.phoneNumber,
        AppKeys.keyImage: studentInfo.image,
      },
    );

    await _apiClientService.post(
      AppApi.studentInfo,
      data: formData,
    );
  }

  Future<void> followTwitterMission({required MultipartFile imageFile}) async {
    final formData = FormData.fromMap(
      {
        AppKeys.keyImage: imageFile,
      },
    );

    await _apiClientService.post(
      AppApi.followTwitter,
      data: formData,
    );
  }

  Future<void> likeTwitterMission({required MultipartFile imageFile}) async {
    final formData = FormData.fromMap(
      {
        AppKeys.keyImage: imageFile,
      },
    );

    await _apiClientService.post(
      AppApi.likeTwitter,
      data: formData,
    );
  }

  Future<void> retweetTwitterMission({required MultipartFile imageFile}) async {
    final formData = FormData.fromMap(
      {
        AppKeys.keyImage: imageFile,
      },
    );

    await _apiClientService.post(
      AppApi.retweetTwitter,
      data: formData,
    );
  }

  Future<void> commentOnTwitterMission({required MultipartFile imageFile}) async {
    final formData = FormData.fromMap(
      {
        AppKeys.keyImage: imageFile,
      },
    );
    await _apiClientService.post(
      AppApi.commentOnTwitter,
      data: formData,
    );
  }

  Future<void> joinTelegramChannelMission() async {
    await _apiClientService.post(
      AppApi.joinTelegramChannel,
    );
  }

  Future<void> joinDiscussionGroupMission() async {
    await _apiClientService.post(
      AppApi.joinDiscussionGroup,
    );
  }

  Future<void> joinDariwallTelegramChannelMission() async {
    await _apiClientService.post(
      AppApi.joinDariwallTelegramChannel,
    );
  }

  Future<void> likeCoinmarketcapMission({required MultipartFile imageFile}) async {
    final formData = FormData.fromMap(
      {
        AppKeys.keyImage: imageFile,
      },
    );

    await _apiClientService.post(
      AppApi.likeCoinmarketcap,
      data: formData,
    );
  }

  Future<void> likeCoinGeckoMission({required MultipartFile imageFile}) async {
    final formData = FormData.fromMap(
      {
        AppKeys.keyImage: imageFile,
      },
    );

    await _apiClientService.post(
      AppApi.likeCoinGecko,
      data: formData,
    );
  }

  Future<List<ProvinceModel>> getProvinces() async {
    final response = await _apiClientService.get(AppApi.provinces);
    return (response.data as List).map((e) => ProvinceModel.fromJson(e)).toList();
  }

  Future<List<MissionModel>> getMissions() async {
    final response = await _apiClientService.get(AppApi.missions);
    return (response.data as List).map((e) => MissionModel.fromJson(e)).toList();
  }
}
